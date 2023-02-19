// // ignore_for_file: recursive_getters, avoid_print

// import 'dart:async';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:tawmen_project/Featurs/Core/strings.dart';
// import 'package:tawmen_project/Featurs/Data/model/details_model.dart';
// import 'package:tawmen_project/Featurs/Data/model/tamwen.dart';

// class DataBaseHelper {
//   DataBaseHelper._();
//   static final DataBaseHelper db = DataBaseHelper._();

//   Future<Database?> get getDb async {
//     Database? dbHelp;
//     if (dbHelp != null) {
//       return dbHelp;
//     } else {
//       return await initilDb();
//     }
//   }

//   Future<Database> initilDb() async {
//     //  ده بتعمل موقع افتراضي ل الداتا بيز
//     String dataBasePath = await getDatabasesPath();
//     //   ده علشان اقوم بحفظ المسار للداتا
//     String path = join(dataBasePath, 'Cards.db');
//     //  ده بقي اللى بتعملى او بتفتحلى الداتا بيز علشان اعمل دانا بيز
//     return await openDatabase(path,
//         onCreate: _onCreate, version: 1, onUpgrade: onUpgrade);
//   }

//   FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
//     // await db.execute("ALTER TABLE $columnNames Add $columnImage TEXT");
//     // print('upgrade');
//   }

//   _onCreate(Database db, int version) async {
//     await db.execute('''
// CREATE TABLE $columnNames (
//   $columnName TEXT,
//   $columnNumberOfMainPeople REAL,
//   $columnNumberOfAdditionalPeople REAL,
//   $columnId INTEGER PRIMARY KEY,
//   $columnPriceOfExtraPeople REAL
// )
// ''');

//     await db.execute('''
// CREATE TABLE $detailsColumn (
//   $imageProduct TEXT,
//   $nameProductColumn TEXT,
//   $priceForOneProductColumn REAL,
//   $counterColumn INTEGER,
//   $detailsId INTEGER PRIMARY KEY
// )
// ''');
//   }

//   // Create
//   // Future<int> insert(Tamwen user) async {
//   //   var myDb = await getDb;
//   //   int response = await myDb!.insert(
//   //     columnNames,
//   //     user.toJson(),
//   //     conflictAlgorithm: ConflictAlgorithm.replace,
//   //   );
//   //   return response;
//   // }

//   // // Read All user
//   // Future<List<Tamwen>> getAllData() async {
//   //   var myDb = await getDb;
//   //   List<Map> response = await myDb!.query(columnNames);
//   //   return response.isNotEmpty
//   //       ? response.map((user) => Tamwen.fromJson(user)).toList()
//   //       : [];
//   // }

//   Future<int> insertDetails(DetailsData details) async {
//     var myDb = await getDb;
//     int response = await myDb!.insert(
//       detailsColumn,
//       details.toJson(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     return response;
//   }

//   Future<List<DetailsData>> getAllDataForDetails() async {
//     var myDb = await getDb;
//     List<Map> response = await myDb!.query(detailsColumn);
//     return response.isNotEmpty
//         ? response
//             .map((detailsData) => DetailsData.fromJson(detailsData))
//             .toList()
//         : [];
//   }

//   // Update
//   // Future<int> update(Tamwen user, String table) async {
//   //   Database? myDb = await getDb;
//   //   int response = await myDb!.update(
//   //     columnNames,
//   //     user.toJson(),
//   //     where: ' $columnId = ?',
//   //     whereArgs: [user.id],
//   //   );
//   //   return response;
//   // }

//   // Delete User
//   Future<int> deleteData(int id, String table, String columnID) async {
//     Database? myDb = await getDb;
//     int user =
//         await myDb!.delete(table, where: " $columnID = ?", whereArgs: [id]);
//     return user;
//   }

//   //  Read 1 User
//   readOneUser(int id) async {
//     Database? myDb = await getDb;
//     return await myDb!.query(
//       columnNames,
//       where: ' $columnId = ?',
//       whereArgs: [id],
//     );
//   }

//   // To Delete All DataBase
//   deleteAllDataBase() async {
//     //  ده بتعمل موقع افتراضي ل الداتا بيز
//     String dataBasePath = await getDatabasesPath();
//     //   ده علشان اقوم بحفظ المسار للداتا
//     String path = join(dataBasePath, 'Card.db');
//     await deleteDatabase(path);
//   }
// }
