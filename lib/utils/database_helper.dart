import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

    // database table and column names
final String tableUser = 'User';
final String columnId = '_id';
final String columnFirebaseToken = 'firebase_token';
final String columnName = 'name';
final String columnAge = 'age';
final String columnPhonenumber = 'phonenumber';
final String columnUidLine = 'uidLine';
final String columnTimestamp = 'timestamp';
final String columnUrlImages = 'urlImages';


    // data model class
class UserSQL{

      int id;
      String firebaseToken;
      String name;
      String age;
      String phonenumber;
      String uidLine;
      String timestamp;
      String urlImages;

      UserSQL({this.id, this.firebaseToken, this.name, this.age, this.phonenumber, this.uidLine, this.timestamp, this.urlImages});

      // convenience constructor to create a Word object
      UserSQL.fromMap(Map<String, dynamic> map) {
        id = map[columnId];
        firebaseToken = map[columnFirebaseToken];
        name = map[columnName];
        age = map[columnAge];
        phonenumber = map[columnPhonenumber];
        uidLine = map[columnUidLine];
        timestamp = map[columnTimestamp];
        urlImages = map[columnUrlImages];
      }

      // convenience method to create a Map from this Word object
      Map<String, dynamic> toMap() {
        var map = <String, dynamic>{
          columnId: 1,
          columnFirebaseToken: firebaseToken,
          columnName: name,
          columnAge: age,
          columnPhonenumber: phonenumber,
          columnUidLine: uidLine,
          columnTimestamp: timestamp,
          columnUrlImages: urlImages
        };
        if (id != null) {
          map[columnId] = id;
        }
        return map;
      }
}

    // singleton class to manage the database
class DatabaseHelper {

      // This is the actual database filename that is saved in the docs directory.
      static final _databaseName = "User.db";
      // Increment this version when you need to change the schema.
      static final _databaseVersion = 1;

      // Make this a singleton class.
      DatabaseHelper._privateConstructor();
      static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

      // Only allow a single open connection to the database.
      static Database _database;
      Future<Database> get database async {
        if (_database != null) return _database;
        _database = await _initDatabase();
        return _database;
      }

      // open the database
      _initDatabase() async {
        // The path_provider plugin gets the right directory for Android or iOS.
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, _databaseName);
        // Open the database. Can also add an onUpdate callback parameter.
        return await openDatabase(path,
            version: _databaseVersion,
            onCreate: _onCreate);
      }

      // SQL string to create the database 
      Future _onCreate(Database db, int version) async {
        await db.execute('''
              CREATE TABLE $tableUser (
                $columnId INTEGER PRIMARY KEY,
                $columnFirebaseToken TEXT NOT NULL,
                $columnName TEXT NOT NULL,
                $columnAge TEXT NOT NULL,
                $columnPhonenumber TEXT NOT NULL,
                $columnUidLine TEXT NOT NULL,
                $columnTimestamp TEXT NOT NULL,
                $columnUrlImages TEXT NOT NULL
              )
              ''');
      }

      // Database helper methods:

      Future<int> insert(UserSQL user) async {
        Database db = await database;
        int id = await db.insert(tableUser, user.toMap());
        return id;
      }

      Future<UserSQL> queryUser(int id) async {
        Database db = await database;
        List<Map> maps = await db.query(tableUser,
            columns: [columnId, columnFirebaseToken, columnName, columnAge, columnPhonenumber, columnUidLine, columnTimestamp, columnUrlImages],
            where: '$columnId = ?',
            whereArgs: [id]);
        if (maps.length > 0) {
          return UserSQL.fromMap(maps.first);
        }
        return null;
      }

      Future<int> deleteUser() async{
        Database db = await database;
        int id = await db.delete(tableUser, where: '_id = ?', whereArgs: [1]);
        return id;
      }

      // TODO: queryAllWords()
      // TODO: delete(int id)
      // TODO: update(Word word)
}


