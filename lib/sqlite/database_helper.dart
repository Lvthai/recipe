import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:recipe_app/models/recipe.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE recipes (
  id $idType,
  name $textType,
  category $textType
)
''');
  }

  Future<Recipe> create(Recipe recipe) async {
    final db = await instance.database;
    final id = await db.insert('recipes', recipe.toMap());
    return recipe.copy(id: id);
  }

  Future<List<Recipe>> readAllRecipes() async {
    final db = await instance.database;

    final orderBy = 'name ASC';
    final result = await db.query('recipes', orderBy: orderBy);

    return result.map((json) => Recipe.fromMap(json)).toList();
  }

  Future<int> update(Recipe recipe) async {
    final db = await instance.database;

    return db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
