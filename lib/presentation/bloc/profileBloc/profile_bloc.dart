import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';

import '../../../core/logger.dart';
import '../../../data/model/update_additional_info_model.dart';
import '../../../domain/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(const ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      try {
        late final ProfileState data;
        emit(const ProfileLoadingState());
        if (event is InitiateUpdateAdditionalInfo) {
          data = await _updateAdditionalInfo(event, emit);
        } else if (event is FetchPersonalDetails) {
          data = await _fetchPersonalDetails(event, emit);
        } else if (event is UpdateProfileBasicInfoEvent) {
          data = await _updateProfileBasicInfo(event, emit);
        }
        emit(data);
      } catch (e) {
        logger.e(e.toString());
        emit(ProfileErrorState(message: e.toString()));
      }
    });
  }

  Future<ProfileState> _updateAdditionalInfo(
      InitiateUpdateAdditionalInfo event, Emitter emit) async {
    final possibleData = await _repository.updateAdditionalInfoAPI(
      house: event.house,
      aboutMe: event.aboutMe,
      birthDate: event.birthDate,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => UpdateAdditionalInfoState(updateAdditionalInfo: r),
    );
  }

  Future<ProfileState> _fetchPersonalDetails(
    FetchPersonalDetails event,
    Emitter emit,
  ) async {
    final possibleData = await _repository.fetchPersonalDetails();
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadPersonalDetailsState(loginAndBasicInfoData: r),
    );
  }

  Future<ProfileState> _updateProfileBasicInfo(
      UpdateProfileBasicInfoEvent event, Emitter emit) async {
    final possibleData = await _repository.updateProfileBasicInfoAPI(
      basicInfoRequestData: event.basicInfoRequestData,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadUpdateProfileBasicInfoState(loginAndBasicInfoData: r),
    );
  }
}
