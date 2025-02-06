import 'package:beta_winker_proj/bloc/diary_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:beta_winker_proj/storages/models/project.dart';
import 'package:beta_winker_proj/storages/models/diary.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit({ProjectState? project}) : super(project ?? const ProjectState());
}
