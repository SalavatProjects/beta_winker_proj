import 'package:isar/isar.dart';
import 'project.dart';

part 'diary.g.dart';

@collection
class Diary {
  Id id = Isar.autoIncrement;

  String? subject;
  DateTime? date;
  String? description;
  String? mark;
  String? category;
  List<String>? videoPaths;
  List<String>? imagePaths;
  List<int>? projectIds;
}