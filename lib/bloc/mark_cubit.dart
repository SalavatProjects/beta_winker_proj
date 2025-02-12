import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../storages/models/mark.dart';

part 'mark_state.dart';

class MarkCubit extends Cubit<MarkState> {
  MarkCubit({MarkState? mark}) : super(mark ?? const MarkState());

  void updateName(String value) {
    emit(state.copyWith(name: value));
  }
}

