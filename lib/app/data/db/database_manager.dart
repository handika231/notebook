import 'package:hive/hive.dart';

part 'database_manager.g.dart';

@HiveType(typeId: 0)
class DBNotes extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? image;
}

class DatabaseManager {
  static Box<DBNotes> getAllNotes() => Hive.box('notes');
}
