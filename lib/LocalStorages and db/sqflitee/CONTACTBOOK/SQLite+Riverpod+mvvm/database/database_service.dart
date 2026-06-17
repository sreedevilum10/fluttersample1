import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact.dart';

class DatabaseService {
  static final DatabaseService _instance
  = DatabaseService._internal();
// DatabaseService db = DatabaseService._internal();cannot use from outside the class
  DatabaseService._internal();
  factory DatabaseService() {
    return _instance;
  }

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(),
                       'contacts_database.db');
            //data/0/user/com.example.contactbook/database/contacts_database.db
    return openDatabase(
      path,
      version: 1,
      onCreate: _createTables,//run only once db is created for first time
      onOpen: (db) {
        print('✅ Database opened');
      },
    );
  }
  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        icon TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
    print('✅contacts table created');
  }

  // CREATE
  Future<int> insertContact(Contact contact) async {
    final db = await database;
    Map<String, dynamic> contactMap = contact.toMap();
    if (contactMap['id'] == null) {
      contactMap.remove('id');
    }
    int id = await db.insert(
      'contacts',
      contactMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('✅ Contact inserted with id: $id');
    return id;
  }

  // READ - All contacts
  Future<List<Contact>> getAllContacts() async {
    final db = await database;

    final List<Map<String, dynamic>> contactMaps = await db.query(
      'contacts',
      orderBy: 'createdAt DESC',
    );
    print('✅ Loaded ${contactMaps.length} contacts');
    return contactMaps.map((map) => Contact.fromMap(map)).toList();
  }

  // READ - Single contact
  Future<Contact?> getContactById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> contactMaps = await db.query(
      'contacts',
      where: 'id = ?', // where id = 5
      whereArgs: [id],
      limit: 1,
    );
    if (contactMaps.isEmpty) {
      print('❌ Contact with id $id not found');
      return null;
    }
    print('✅ Contact with id $id found');
    return Contact.fromMap(contactMaps.first);
  }

  // SEARCH
  Future<List<Contact>> searchContacts(String searchTerm) async {
    final db = await database;

    final List<Map<String, dynamic>> contactMaps = await db.query(
      'contacts',
      where: 'LOWER(name) LIKE ?',
      whereArgs: ['%${searchTerm.toLowerCase()}%'],
      orderBy: 'name ASC',
    );

    print('✅ Found ${contactMaps.length} contacts matching "$searchTerm"');
    return contactMaps.map((map) => Contact.fromMap(map)).toList();
  }

  // UPDATE
  Future<int> updateContact(Contact contact) async {
    final db = await database;
    if (contact.id == null) {
      throw Exception('Cannot update contact without id');
    }
    Map<String, dynamic> contactMap = contact.toMap();
    int rowsUpdated = await db.update(
      'contacts',
      contactMap,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
    print('✅ Contact updated: $rowsUpdated rows affected');
    return rowsUpdated;
  }

  // DELETE - Single
  Future<int> deleteContact(int id) async {
    final db = await database;
    int rowsDeleted = await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('✅ Contact deleted: ''$rowsDeleted rows affected');
    return rowsDeleted;
  }

  // DELETE - All
  Future<int> deleteAllContacts() async {
    final db = await database;
    int rowsDeleted = await db.delete('contacts');

    print('⚠️ All contacts deleted:'
        ' $rowsDeleted rows affected');
    return rowsDeleted;
  }

  // COUNT
  Future<int> getContactsCount() async {
    final db = await database;

    final result = await db.rawQuery('SELECT COUNT(*) as count FROM contacts');
    int count = Sqflite.firstIntValue(result) ?? 0;

    print('✅ Total contacts: $count');
    return count;
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      print('✅ Database closed');
    }
  }
}
