import 'package:beta_winker_proj/bloc/project_cubit.dart';
import 'package:beta_winker_proj/storages/models/project.dart';
import 'package:bloc/bloc.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:beta_winker_proj/storages/models/diary.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit({DiaryState? diary}) : super(diary ?? const DiaryState());
}
