import 'package:isar/isar.dart';

part 'location.g.dart';

@collection
class Location {
  Id id = Isar.autoIncrement;

  String? name;
  String? mark;
  String? category;
}