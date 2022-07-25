import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/filter_data_request_model.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../data/model/users_model.dart';
import '../../../domain/users_repository.dart';
import '../../../features/location_manager.dart';

part 'near_by_users_state.dart';

class NearByUsersCubit extends Cubit<NearByUsersState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final UsersRepository _repository;
  final LocationManager _locationManager;

  NearByUsersCubit(this._repository, this._locationManager) : super(NearByUsersInitial());

  void loadUsers() async {
    if (state is LoadingNearByUsersState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadNearByUsersState) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingNearByUsersState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchNearByUsersAPI(
        filterDataRequestData: FilterDataRequestModel(page: _page));

    if (possibleData.isLeft()) {
      emit(ErrorLoadingNearByUsersState(
          title: StringResources.errorTitle, message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final users = (state as LoadingNearByUsersState).oldUsers;
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadNearByUsersState(usersData: users));
  }

  bool get isListFetchingComplete => _isListFetchingComplete;

  Future<bool> handleUserLocation() async {
    final possibleData = await _locationManager.fetchLocationData();

    if (possibleData.isLeft()) {
      emit(ErrorLoadingNearByUsersState(
          title: StringResources.locationErrorTitle, message: possibleData.getLeft()!.error));
      return false;
    }

    _repository.updateUserCurrentLocation(
        possibleData.getRight()!.latitude!, possibleData.getRight()!.longitude!);
    return true;
  }

  Map<String, dynamic> fetchCachedFilterData() => _repository.fetchCachedFilterData();

  void filterList({required FilterDataRequestModel filterData}) async {
    emit(LoadingNearByUsersState(const [], isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchNearByUsersAPI(filterDataRequestData: filterData);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingNearByUsersState(
        message: possibleData.getLeft()!.error,
        title: StringResources.errorTitle,
      ));
      return;
    }
    _page++;
    final List<UserDataModel> users = [];
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadNearByUsersState(usersData: users));
  }
}
