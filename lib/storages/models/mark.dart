import 'package:isar/isar.dart';

part 'mark.g.dart';

@collection
class Mark{
  Id id = Isar.autoIncrement;

  String? name;
}