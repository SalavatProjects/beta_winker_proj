import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:beta_winker_proj/storages/models/diary.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit({DiaryState? diary}) : super(diary ?? const DiaryState());

  void updateSubject(String value) {
    emit(state.copyWith(subject: value));
  }

  void updateDate(DateTime value) {
    emit(state.copyWith(date: value));
  }

  void updateDescription(String value) {
    emit(state.copyWith(description: value));
  }

  void updateMark(String value) {
    emit(state.copyWith(mark: value));
  }

  void updateCategory(String value) {
    emit(state.copyWith(category: value));
  }

  void updateVideoPath(String value) {
    emit(state.copyWith(videoPath: value));
  }

  void updateImagePath(String value) {
    emit(state.copyWith(imagePath: value));
  }

  void addProjectId(int value) {
    emit(state.copyWith(projectIds: List.from(state.projectIds)..add(value)));
  }

  void removeProjectId(int value) {
    emit(state.copyWith(projectIds: List.from(state.projectIds)..remove(value)));
  }
}
