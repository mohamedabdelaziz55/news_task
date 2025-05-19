import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'bookmarks.db';

  static const String tableArticles = 'bookmarked_articles';
  static const String tableCategories = 'bookmarked_categories';


  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableArticles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableCategories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        title TEXT,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insertArticle(Map<String, dynamic> article) async {
    final db = await database;
    return await db.insert(tableArticles, article);
  }

  Future<List<Map<String, dynamic>>> getArticles() async {
    final db = await database;
    return await db.query(tableArticles);
  }

  Future<int> deleteArticle(String url) async {
    final db = await database;
    return await db.delete(tableArticles, where: 'url = ?', whereArgs: [url]);
  }


  Future<int> insertCategory(Map<String, dynamic> category) async {
    final db = await database;
    return await db.insert(tableCategories, category);
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    return await db.query(tableCategories);
  }

  Future<int> deleteCategory(String category) async {
    final db = await database;
    return await db.delete(tableCategories, where: 'category = ?', whereArgs: [category]);
  }
}
