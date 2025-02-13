import 'dart:async';
import 'package:beta_winker_proj/storages/models/category.dart';
import 'package:beta_winker_proj/storages/models/mark.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models/diary.dart';
import 'models/location.dart';
import 'models/project.dart';

abstract class AppIsarDatabase {
  static late final Isar _instance;

  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return _instance = await Isar.open(
        [DiarySchema, LocationSchema, ProjectSchema, MarkSchema, CategorySchema],
        directory: dir.path);
  }

  /*static Future<Filters?> getFilters() async {
    if (await _instance.filters.where().findFirst() == null) {
      Filters newFilters = Filters()..id = 1;
      await _instance.writeTxn(
              () async => await _instance.filters.put(newFilters)
      );
    }
    return await _instance.writeTxn(
        () async => await _instance.filters.where().findFirst(),
    );
  }

  static Future<void> updateFilters(Filters newFilters) async {
    await _instance.writeTxn(() async {
      final filters = await _instance.filters.where().findFirst();
      if (filters != null) {
        filters
          ..categories = newFilters.categories
          ..marks = newFilters.marks;
        return await _instance.filters.put(filters);
      }
    });
  }*/

  static Future<List<Diary>> getDiaries() async {
    return await _instance.writeTxn(
        () async => await _instance.diarys.where().findAll(),
    );
  }

  static Future<void> addDiary(Diary diary) async {
    await _instance.writeTxn(() async => await _instance.diarys.put(diary));
  }

  static Future<void> deleteDiary(int id) async {
    await _instance.writeTxn(() async => await _instance.diarys.delete(id));
  }

  static Future<void> updateDiaryProjectIds(int id, List<int> newProjectIds) async {
    await _instance.writeTxn(() async {
      final diary = await _instance.diarys.get(id);
      if (diary != null) {
        diary.projectIds = newProjectIds;
        return await _instance.diarys.put(diary);
      }
    });
  }

  static Future<List<Project>> getProjects() async {
    return await _instance.writeTxn(
        () async => await _instance.projects.where().findAll(),
    );
  }

  static Future<void> addProject(Project project) async {
    await _instance.writeTxn(() async => await _instance.projects.put(project));
  }

  static Future<void> deleteProject(int id) async {
    await _instance.writeTxn(() async => await _instance.projects.delete(id));
  }

  static Future<List<Location>> getLocations() async {
    return await _instance.writeTxn(
        () async => await _instance.locations.where().findAll(),
    );
  }

  static Future<void> addLocation(Location location) async {
    await _instance.writeTxn(() async => await _instance.locations.put(location));
  }

  static Future<void> updateLocation(int id, Location newLocation) async {
    await _instance.writeTxn(() async {
      final location = await _instance.locations.get(id);
      if (location != null) {
        location
          ..name = newLocation.name
          ..mark = newLocation.mark
          ..category = newLocation.category;
        return await _instance.locations.put(location);
      }
    });
  }

  static Future<List<Mark>> getMarks() async {
    return await _instance.writeTxn(
          () async => await _instance.marks.where().findAll(),
    );
  }

  static Future<void> addMark(Mark mark) async {
    await _instance.writeTxn(() async => await _instance.marks.put(mark));
  }

  static Future<List<Category>> getCategories() async {
    return await _instance.writeTxn(
          () async => await _instance.categorys.where().findAll(),
    );
  }

  static Future<void> addCategory(Category category) async {
    await _instance.writeTxn(() async => await _instance.categorys.put(category));
  }
}