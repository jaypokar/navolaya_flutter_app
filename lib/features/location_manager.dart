import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart' as place;
import 'package:google_place/google_place.dart' as google_place;
import 'package:location/location.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/core/global_nav_key.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/features/socket_connection_manager.dart';
import 'package:navolaya_flutter/resources/config_file.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../injection_container.dart';
import '../util/common_functions.dart';

class LocationManager {
  late final Location _location = Location();
  final SocketConnectionManager _socketConnectionManager;
  bool _isLocationEnabledForListening = false;
  LocationData? _locationData;
  final google_place.GooglePlace _googlePlace =
      google_place.GooglePlace(ConfigFile.googleMapAPIKey);

  late final place.GoogleMapsPlaces places;

  LocationManager(this._socketConnectionManager) {
    initiatePlaceObject();
  }

  void initiatePlaceObject() async {
    places = place.GoogleMapsPlaces(
      apiKey: ConfigFile.googleMapAPIKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
  }

  Future<Either<Failure, LocationData?>> fetchLocationData() async {
    final permissionData = await _checkLocationPermissions();
    if (permissionData.isLeft()) {
      return left(permissionData.getLeft()!);
    }
    await _enableLocationListeningService();

    logger.i(
      'the location data is fetched :'
      ' \nLatitude : ${_locationData!.latitude}'
      '\nLongitude : ${_locationData!.longitude}',
    );
    return right(_locationData);
  }

  Future<Either<Failure, Unit>> _checkLocationPermissions() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied ||
        permissionGranted == PermissionStatus.deniedForever) {
      final result = await _showLocationEnableInformationToUser();
      if (result) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted == PermissionStatus.denied) {
          return left(const Failure(StringResources.nearByLocationFetchTitle));
        } else if (permissionGranted == PermissionStatus.deniedForever) {
          return left(const Failure(StringResources.nearByLocationFetchTitle));
        }
      } else {
        return left(const Failure(StringResources.nearByLocationFetchTitle));
      }
    }

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (serviceEnabled) {
        return right(unit);
      } else {
        return left(const Failure(StringResources.nearByLocationFetchTitle));
      }
    }

    return right(unit);
  }

  Future<bool> _showLocationEnableInformationToUser() async {
    return await sl<CommonFunctions>().showConfirmationDialog(
      context: GlobalNavKey.navState.currentState!.context,
      title: StringResources.locationInfoPermission,
      message: StringResources.locationInfoPermissionDesc,
      buttonPositiveText: StringResources.locationInfoPermissionAllow,
      buttonNegativeText: StringResources.locationInfoPermissionNotNow,
    );
  }

  Future<void> _enableLocationListeningService() async {
    if (!_isLocationEnabledForListening) {
      _isLocationEnabledForListening = true;
      _locationData = await _location.getLocation();
      _location.enableBackgroundMode(enable: false);
      _location.changeSettings(distanceFilter: 30, interval: 20000);
      _location.onLocationChanged.listen((LocationData currentLocation) {
        _locationData = currentLocation;
        logger.d('''\n
                        Latitude:  ${currentLocation.latitude}
                        Longitude: ${currentLocation.longitude}
                        Time: ${currentLocation.time}
                      ''');
        _socketConnectionManager.updateUserCurrentLocation(
            currentLocation.latitude!, currentLocation.longitude!);
      });
    }
  }

  Future<Either<Failure, place.Geometry>> displayPrediction(String placeId) async {
    try {
      place.PlacesDetailsResponse detail = await places.getDetailsByPlaceId(placeId);
      return right(detail.result.geometry!);
    } catch (e) {
      logger.e(e);
      return left(const Failure(StringResources.errorTitle));
    }
  }

  LocationData? get locationData => _locationData;

  google_place.GooglePlace get googlePlace => _googlePlace;

  Future<List<geocode.Placemark>?> fetchUserAddress(double latitude, double longitude) async {
    List<geocode.Placemark> address = await geocode.placemarkFromCoordinates(latitude, longitude);
    return address;
  }
}
