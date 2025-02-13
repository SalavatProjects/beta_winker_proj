import 'package:beta_winker_proj/bloc/mark_cubit.dart';
import 'package:beta_winker_proj/bloc/project_cubit.dart';
import 'package:beta_winker_proj/storages/isar.dart';
import 'package:beta_winker_proj/storages/models/category.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../storages/models/mark.dart';
import 'category_cubit.dart';
import 'diary_cubit.dart';
import 'location_cubit.dart';

part 'entities_state.dart';

class EntitiesCubit extends Cubit<EntitiesState> {
  EntitiesCubit() : super(const EntitiesState());

  Future<void> getEntities() async {
    await getDiaries();
    await getProjects();
    await getLocations();
    await getMarks();
    await getCategories();
  }

  Future<void> getDiaries() async {
    final diaries = await AppIsarDatabase.getDiaries();
    emit(state.copyWith(
      diaries: diaries.map((e) => DiaryState.fromIsarModel(e)).toList()
    ));
  }

  Future<void> addDiary(DiaryState diary) async {
    await AppIsarDatabase.addDiary(diary.toIsarModel());
    await getDiaries();
  }

  Future<void> deleteDiary(int id) async {
    await AppIsarDatabase.deleteDiary(id);
    await getDiaries();
  }

  Future<void> updateDiaryProjectIds(int id, int newProjectId) async {
    DiaryState? diary = state.diaries.firstWhereOrNull((e) => e.id == id);
    if (diary != null) {
      List<int> diaryProjectIds = List.from(diary.projectIds);
        if (!diaryProjectIds.contains(newProjectId)) {
          diaryProjectIds.add(newProjectId);
        }

      await AppIsarDatabase.updateDiaryProjectIds(id, diaryProjectIds);
      await getDiaries();
    }

  }

  Future<void> getProjects() async {
    final projects = await AppIsarDatabase.getProjects();
    emit(state.copyWith(
      projects: projects.map((e) => ProjectState.fromIsarModel(e)).toList()
    ));
  }

  Future<void> addProject(ProjectState project) async {
    await AppIsarDatabase.addProject(project.toIsarModel());
    await getProjects();
  }

  Future<void> deleteProject(int id) async {
    await AppIsarDatabase.deleteProject(id);
    await getProjects();
  }

  Future<void> getLocations() async {
    final locations = await AppIsarDatabase.getLocations();
    emit(state.copyWith(
      locations: locations.map((e) => LocationState.fromIsarModel(e)).toList()
    ));
  }

  Future<void> addLocation(LocationState location) async {
    await AppIsarDatabase.addLocation(location.toIsarModel());
    await getLocations();
  }

  Future<void> updateLocation(int id, LocationState location) async {
    await AppIsarDatabase.updateLocation(id, location.toIsarModel());
    await getLocations();
  }

  Future<void> getMarks() async {
    final marks = await AppIsarDatabase.getMarks();
    emit(state.copyWith(
      marks: marks.map((e) => MarkState.fromIsarModel(e)).toList()
    ));
  }

  Future<void> addMark(MarkState mark) async {
    await AppIsarDatabase.addMark(mark.toIsarModel());
    await getMarks();
  }

  Future<void> getCategories() async {
    final categories = await AppIsarDatabase.getCategories();
    emit(state.copyWith(
        categories: categories.map((e) => CategoryState.fromIsarModel(e)).toList()
    ));
  }

  Future<void> addCategory(CategoryState category) async {
    await AppIsarDatabase.addCategory(category.toIsarModel());
    await getCategories();
  }
}
