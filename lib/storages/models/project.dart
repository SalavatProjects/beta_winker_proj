import 'package:isar/isar.dart';
import 'diary.dart';

part 'project.g.dart';

@collection
class Project {
  Id id = Isar.autoIncrement;

  String? name;
  String? description;
  List<int>? diaryIds;
}