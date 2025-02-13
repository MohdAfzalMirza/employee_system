import 'dart:async';
import 'dart:io';

import 'package:demo/utils/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const kStringSeparator = '¯';
const _kTag = 'DatabaseHelper';

/// DO NOT USE THESE WORDS IN TABLE OR COLUMNS
/// "add","all","alter","and","as",
/// "autoincrement","between","case",
/// "check","collate","commit","constraint",
/// "create","default","deferrable","delete",
/// "distinct","drop","else","escape","except",
/// "exists","foreign","from","group","having",
/// "if","in","index","insert","intersect","into",
/// "is","isnull","join","limit","not","notnull",
/// "null","on","or","order","primary","references",
/// "select","set","table","then","to","transaction",
/// "union","unique","update","using","values","when","where"
class DatabaseHelper {
  static const _databaseName = "TeachDataBase.db";
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  static String? path;

  DatabaseHelper.internal();

  /// Increase Migration key by 1 and Add Migration Script as Value
  final Map<int, String> migrationScripts = {
    // 1: EmployeeTableProvider.createTableCMD,
  };

  FutureOr<Database> get db async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, _databaseName);
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }

  initDb() async {
    final int dbVersion = migrationScripts.length;
    return await openDatabase(path!, version: dbVersion,
        onCreate: (db, version) async {
      Logger.info(_kTag, "onCreate $dbVersion");
      // Run all script to create new table & migration (default overwrites)
      for (int i = 1; i <= dbVersion; i++) {
        try {
          if (migrationScripts.containsKey(i)) {
            await db.execute(migrationScripts[i]!);
          }
        } on Exception catch (e, stack) {
          Logger.shout(_kTag, "onCreate : DB Version $i : ", e, stack);
        }
      }
    }, onUpgrade: (db, oldVersion, newVersion) async {
      Logger.info(_kTag, "onUpGrade $oldVersion - $newVersion");
      // Run migrations from old version to new version
      for (int i = oldVersion + 1; i <= newVersion; i++) {
        try {
          await db.execute(migrationScripts[i]!);
        } on Exception catch (e, stack) {
          Logger.shout(_kTag, "onUpgrade DB Version $i : ", e, stack);
        }
      }
    });
  }

  Future closeDB() async {
    (await db).close();
    _database = null;
  }

  Future deleteDB() async {
    await deleteDatabase(path!);
    await closeDB();
  }
}
