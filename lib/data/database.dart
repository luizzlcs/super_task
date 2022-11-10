import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:super_task/data/task_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task2.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TaskDAO.tableSql);
    },
    version: 1,
  );
}
