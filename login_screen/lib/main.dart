import "package:flutter/material.dart";
import "package:login_screen/splash_screen.dart";
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

dynamic database;

Future<void> insertData(UserDetails user) async {
  final localDB = await database;

  await localDB.insert(
    'user',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> deleteData(UserDetails user) async {
  final localDB = await database;

  localDB.delete(
    'user',
    where: 'username = ?',
    whereArgs: [user.username],
  );
}

Future<void> updateData(UserDetails user) async {
  final localDB = await database;

  localDB.update(
    'user',
    user.toMap(),
    where: 'username = ?',
    whereArgs: [user.username],
  );
}

Future<List<UserDetails>> showDetails() async {
  final localDB = await database;

  List<Map<String, dynamic>> list = await localDB.query('user');

  return List.generate(list.length, (index) {
    return UserDetails(
      username: list[index]['username'],
      password: list[index]['password'],
    );
  });
  // return list;
}

class UserDetails {
  String username;
  String password;

  UserDetails({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'username: $username, password: $password';
  }
}

void main() async {
  // Widget.flutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), 'register.db'),
    version: 1,
    onCreate: (db, version) async {
      return await db.execute(
          'CREATE TABLE user(username TEXT PRIMARY KEY,password TEXT)');
    },
  );

  runApp(const MyApp());

  // insertData(UserDetails(username: "Om", password: "pawar"));
  // insertData(UserDetails(username: "Vaibhav", password: "pagare"));
  // updateData(UserDetails(username: 'Om', password: 'new password'));
  // deleteData(UserDetails(username: 'Om', password: 'akjdhdkljf'));
  showDetails();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
