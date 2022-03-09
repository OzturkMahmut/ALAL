import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
const String tableWords = 'words';
const String columnId = '_id';
const String columnName = 'name';
const String columnMeaning = 'meaning';
const String columnNotes = 'notes';
const String columnisFav = 'isFav';

// data model class
class Word {
  int id;
  String name;
  String meaning;
  String notes;
  int isFav;

  Word({
    required this.id,
    required this.name,
    required this.meaning,
    required this.notes,
    this.isFav = 0,
  });

  /* convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    //NAMED CONSTRUCTOR
    id = map[columnId];
    name = map[columnName];
    meaning = map[columnMeaning];
    notes = map[columnNotes];
  }  */

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnName: name,
      columnMeaning: meaning,
      columnNotes: notes,
      columnisFav: isFav,
    };
    return map;
  }

  // Implement toString to make it easier to see information about
  // each word when using the print statement.
  @override
  String toString() {
    return 'Word{id: $id, name: $name, meaning: $meaning, notes: $notes, isFav: $isFav}';
  }
}

// singleton class to manage the database
class WordDatabase {
  // This is the actual database filename that is saved in the docs directory.
  static const _databaseName = "word_database.db";
  // Increment this version when you need to change the schema.
  static const _databaseVersion = 1;

  // Make this a singleton class.
  WordDatabase._privateConstructor();
  static final WordDatabase instance = WordDatabase._privateConstructor();

  // Only allow a single open connection to the database.
  static late Database _database;
  Future<Database> get database async {
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
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableWords (
                $columnId INTEGER PRIMARY KEY,
                $columnName TEXT NOT NULL,
                $columnMeaning TEXT NOT NULL,
                $columnNotes INTEGER NOT NULL,
                $columnisFav INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insertWord(Word word) async {
    Database db = await database;
    int id = await db.insert(
      tableWords,
      word.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Word>> queryAWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: [
          columnId,
          columnName,
          columnMeaning,
          columnNotes,
          columnisFav
        ],
        where: '$columnId = ?',
        whereArgs: [id]);

    return List.generate(maps.length, (i) {
      return Word(
        id: maps[i]['_id'],
        name: maps[i]['name'],
        meaning: maps[i]['meaning'],
        notes: maps[i]['notes'],
        isFav: maps[i]['isFav'] ?? 0, // x = y ?? z  assign  y to x,unless y is null ,otherwise assign z
      );
    });
  }

  Future<List<Word>> queryFavWords() async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: [
          columnId,
          columnName,
          columnMeaning,
          columnNotes,
          columnisFav
        ],
        where: '$columnisFav = ?',
        whereArgs: [1]);

    return List.generate(maps.length, (i) {
      return Word(
        id: maps[i]['_id'],
        name: maps[i]['name'],
        meaning: maps[i]['meaning'],
        notes: maps[i]['notes'],
        isFav: maps[i]['isFav'] ?? 0, // x = y ?? z  assign  y to x,unless y is null ,otherwise assign z
      );
    });
  }

  Future<int> dataLength() async {
    Database db = await database;
    // Query the table for all The Words.
    final List<Map<String, dynamic>> maps = await db.query('words');
    return maps.length;
  }

  //DİĞER ÖRNEKTEN
  // A method that retrieves all the words from the words table.
  Future<List<Word>> queryAllWords() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Words.
    final List<Map<String, dynamic>> maps = await db.query('words');
    //print(maps);
    // Convert the List<Map<String, dynamic> into a List<Word>.
    return List.generate(maps.length, (i) {
      return Word(
        id: maps[i]['_id'],
        name: maps[i]['name'],
        meaning: maps[i]['meaning'],
        notes: maps[i]['notes'],
        isFav: maps[i]['isFav'] ?? 0, // x = y ?? z  assign  y to x,unless y is null ,otherwise assign z
      );
    });
  }


    Future<List<String>> queryOnlyWords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('words',columns: [columnName]);
    //print(maps);
    // Convert the List<Map<String, dynamic> into a List<Word>.
    return List.generate(maps.length, (i) {
      return String.fromEnvironment(
        maps[i]['name'],
      );
    });
  }

  //DİĞER ÖRNEKTEN
  Future<void> updateWord(Word word) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Word.
    await db.update(
      'words',
      word.toMap(),
      // Ensure that the Word has a matching id.
      where: '_id = ?',
      // Pass the Word's id as a whereArg to prevent SQL injection.
      whereArgs: [word.id],
    );
  }

  Future<void> addColumn(String columnName) async {
    // Get a reference to the database.
    final db = await database;
    //Sql query for adding a table
    await db.execute('ALTER TABLE $tableWords ADD COLUMN $columnName');
  }

  //DİĞER ÖRNEKTEN
  Future<void> deleteWord(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Word from the database.
    await db.delete(
      'words',
      // Use a `where` clause to delete a specific word.
      where: '_id = ?',
      // Pass the Word's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
