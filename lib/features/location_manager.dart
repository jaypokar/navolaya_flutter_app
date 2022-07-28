import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

class LocationManager {
  final Location _location = Location();
  LocationData? _locationData;

  Future<Either<Failure, LocationData?>> fetchLocationData() async {
    final permissionData = await _checkLocationPermissions();
    if (permissionData.isLeft()) {
      return left(permissionData.getLeft()!);
    }
    _locationData = await _location.getLocation();
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
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return right(unit);
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied ||
        permissionGranted == PermissionStatus.deniedForever) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted == PermissionStatus.denied) {
        return left(const Failure(StringResources.locationServiceNotEnabled));
      } else if (permissionGranted == PermissionStatus.deniedForever) {
        return left(const Failure(StringResources.nearByLocationFetchTitle));
      }
    }
    return right(unit);
  }

  LocationData? get locationData => _locationData;

/*Future<List<Placemark>?> fetchUserAddress(double latitude,double longitude) async {
    List<Placemark> address = await placemarkFromCoordinates(latitude, longitude);
    return address;
  }*/

}
