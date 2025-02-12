import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../storages/models/location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({LocationState? location}) : super(location ?? const LocationState());

  void updateName(String value) {
    emit(state.copyWith(name: value));
  }

  void updateMark(String value) {
    emit(state.copyWith(mark: value));
  }

  void updateCategory(String value) {
    emit(state.copyWith(category: value));
  }
}
