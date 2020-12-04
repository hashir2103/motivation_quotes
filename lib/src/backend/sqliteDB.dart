import 'package:motivation_quotes/src/controller/Catergories/catergoryModel.dart';
import 'package:motivation_quotes/src/controller/Notification/reminderModel.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:motivation_quotes/src/controller/collection/ownQuote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDB {
  static Database _db;
  static SqliteDB _sqliteDB;

  SqliteDB._createInstance();
  factory SqliteDB() {
    if (_sqliteDB == null) {
      _sqliteDB = SqliteDB._createInstance();
    }
    return _sqliteDB;
  }

  String dbName = 'QuoteDB';
  String quoteTable = 'quotes';
  String myCategories = 'mycategories';
  String reminderTable = 'reminder';
  String ownQuoteTable = 'ownQuoteTable';

  //Columns quotetable
  String quoteId = 'id';
  String quoteBody = 'body';
  String quoteAuthor = 'author';
  String quoteCatergory = 'catergory';
  String isFav = 'isfav';

  //Columns categoryTable
  String catergoryName = "catName";
  String catergoryShow = 'showCat';

  //Columns own quote
  String id = 'id';
  String quote = 'quote';
  String author = 'author';

  //Coumns Reminder
  String key = 'key';
  String reminderCount = "reminderCount";
  String startTime = 'startTime';
  String endTime = 'endTime';
  String typeOfquote = 'typeOfquote';
  String isUsingAppFirstTime = 'isUsingAppFirstTime';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await init();
    return _db;
  }

  init() async {
    var dir = await getDatabasesPath();
    String path = join(dir, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  deleteDB() async {
    var dir = await getDatabasesPath();
    String path = join(dir, dbName);
    await deleteDatabase(path);
    }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $quoteTable(
        $quoteId Text,
        $quoteBody TEXT,
        $quoteCatergory TEXT,
        $quoteAuthor TEXT,
        $isFav INTEGER
      )''');

    await db.execute('''
      CREATE TABLE $myCategories(
        $catergoryName Text,
        $catergoryShow INTEGER
      )''');

    await db.execute('''
      CREATE TABLE $reminderTable(
        $key INTEGER PRIMARY KEY,
        $reminderCount INTEGER,
        $startTime TEXT,
        $endTime TEXT,
        $typeOfquote TEXT,
        $isUsingAppFirstTime INTEGER
      )''');

    await db.execute('''
      CREATE TABLE $ownQuoteTable(
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $quote TEXT,
        $author TEXT
      )''');

      }

  //reminder func
  addReminder(ReminderModel reminder) async {
    var dbClient = await db;
    await dbClient.insert(reminderTable, reminder.toMap());

  }

  Future<ReminderModel> getReminder() async {
    var dbClient = await db;
    var result =
        await dbClient.query(reminderTable, where: "$key = ?", whereArgs: [1]);
    return ReminderModel.fromMap(result[0]);
  }

  updateReminder(ReminderModel rem) async {
    var dbClient = await db;
    await dbClient.update(
      reminderTable,
      rem.toMap(),
      where: '$key = ?',
      whereArgs: [1],
    );
    }

//ownQuote
  addOwnQuote(OwnQuote quote) async {
    var dbClient = await db;
    await dbClient.insert(ownQuoteTable, quote.toMap());
  }

  Future<List<OwnQuote>> getOwnQuote() async {
    List<OwnQuote> _cat = [];
    var dbClient = await db;
    var result = await dbClient.query(ownQuoteTable, columns: [quote, author]);
    result.forEach((element) {
      var cat = OwnQuote.fromMap(element);
      _cat.add(cat);
    });
    return _cat;
  }

  updateOwnQuote(OwnQuote quote) async {
    var dbClient = await db;
    await dbClient.update(
      ownQuoteTable,
      quote.toMap(),
      where: '$quote = ?',
      whereArgs: [quote.quote],
    );
  }

  deleteOwnQuote(OwnQuote ownquote) async {
    var dbClient = await db;
    await dbClient.delete(ownQuoteTable,
        where: '$quote = ?', whereArgs: [ownquote.quote]);
        
  }

//quote
  addQuote(Quote quote) async {
    var dbClient = await db;
    await dbClient.insert(quoteTable, quote.toMap());
    
  }

  addCat(CatergoryModel cat) async {
    var dbClient = await db;
    await dbClient.insert(myCategories, cat.toMap());
   
  }

  Future<List<Quote>> getQuoteByCatergory(String catergory) async {
    List<Quote> _quotes = [];
    var dbClient = await db;
    var result = await dbClient.query(quoteTable,
        where: '$quoteCatergory = ?', whereArgs: [catergory]);
    result.forEach((element) {
      var quote = Quote.fromMap(element);
      _quotes.add(quote);
    });
    return _quotes;
  }

  Future<List<CatergoryModel>> getMyCat() async {
    List<CatergoryModel> _cat = [];
    int value = 1;
    var dbClient = await db;
    var result = await dbClient
        .query(myCategories, where: '$catergoryShow = ?', whereArgs: [value]);
    result.forEach((element) {
      var cat = CatergoryModel.fromMap(element);
      _cat.add(cat);
    });
    return _cat;
  }

  Future<List<CatergoryModel>> getAllCat() async {
    List<CatergoryModel> _cat = [];
    var dbClient = await db;
    var result = await dbClient
        .query(myCategories, columns: [catergoryName, catergoryShow]);
    result.forEach((element) {
      var cat = CatergoryModel.fromMap(element);
      _cat.add(cat);
    });
    return _cat;
  }

  Future<List<Quote>> getQuoteByCatergories(List<String> catergory) async {
    List<Quote> _quotes = [];
    var dbClient = await db;
    var result = await dbClient.query(quoteTable,
        where:
            "$quoteCatergory IN (${('?' * (catergory.length)).split('').join(', ')})",
        whereArgs: catergory);
    result.forEach((element) {
      var quote = Quote.fromMap(element);
      _quotes.add(quote);
    });
    return _quotes;
  }

  Future<Quote> getSingleQuote(Quote quote) async {
    Quote _quotes;
    var dbClient = await db;
    var result = await dbClient
        .query(quoteTable, where: '$quoteBody = ?', whereArgs: [quote.body]);
    _quotes = Quote.fromMap(result[0]);
    return _quotes;
  }

  Future<List<Quote>> getQuotes() async {
    List<Quote> _quotes = [];
    var dbClient = await db;
    var result = await dbClient.query(quoteTable,
        columns: [quoteId, quoteBody, quoteCatergory, quoteAuthor, isFav]);
    result.forEach((element) {
      var quote = Quote.fromMap(element);
      _quotes.add(quote);
    });
    return _quotes;
  }

  updateQuote(Quote quote) async {
    var dbClient = await db;
    await dbClient.update(
      quoteTable,
      quote.toMap(),
      where: '$quoteBody = ?',
      whereArgs: [quote.body],
    );
  }

  updateCat(CatergoryModel cat) async {
    var dbClient = await db;
    await dbClient.update(
      myCategories,
      cat.toMap(),
      where: '$catergoryName = ?',
      whereArgs: [cat.catergoryName],
    );
    }

//get Fav
  Future<List<Quote>> getFav() async {
    List<Quote> _quotes = [];
    var dbClient = await db;
    var result =
        await dbClient.query(quoteTable, where: '$isFav = ?', whereArgs: [1]);
    result.forEach((element) {
      var quote = Quote.fromMap(element);
      _quotes.add(quote);
    });
    return _quotes;
  }

  deleteAllQuotes() async {
    var dbClient = await db;
    await dbClient.delete(quoteTable);
  }

  deleteAllCat() async {
    var dbClient = await db;
    await dbClient.delete(myCategories);
    }

  close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
