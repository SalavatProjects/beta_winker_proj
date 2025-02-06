import 'package:isar/isar.dart';

part 'filters.g.dart';

@collection
class Filters {
  Id id = Isar.autoIncrement;

  List<String>? marks;
  List<String>? categories;
}