import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
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
  String tableName = 'quotes';

  //Columns
  String quoteId = 'id';
  String quoteBody = 'body';
  String quoteAuthor = 'author';
  String quoteCatergory = 'catergory';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    print("db was null, now awaiting it to initalize");
    _db = await init();
    return _db;
  }

  init() async {
    var dir = await getDatabasesPath();
    String path = join(dir, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String createTableQuery =
        "CREATE TABLE $tableName ($quoteId Text, $quoteBody TEXT, $quoteCatergory TEXT,$quoteAuthor TEXT)";

    await db.execute(createTableQuery);
    print("table created");
  }

  addQuote(Quote quote) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableName, quote.toMap());
    print('result :$result');
  }

  Future<List<Quote>> getQuoteByCatergory(String catergory) async {
    List<Quote> _quotes = [];
    var dbClient = await db;
    var result = await dbClient
        .query(tableName, where: '$quoteCatergory = ?', whereArgs: [catergory]);
    result.forEach((element) {
      var quote = Quote.fromMap(element);
      _quotes.add(quote);
    });
    return _quotes;
  }

  Future<List<Quote>> getQuotes() async {
    List<Quote> _quotes = [];
    var dbClient = await db;
    var result = await dbClient.query(tableName,
        columns: [quoteId, quoteBody, quoteCatergory, quoteAuthor]);
    result.forEach((element) {
      var quote = Quote.fromMap(element);
      _quotes.add(quote);
    });
    return _quotes;
  }

  deleteAllQuotes() async {
    var dbClient = await db;
    return await dbClient.delete(tableName);
    // return await dbClient
    //     .delete(tableName, where: '$quoteId = ?', whereArgs: [id]);
  }

  // updateLogs(Log log) async {
  //   var dbClient = await db;

  //   await dbClient.update(
  //     tableName,
  //     log.toMap(log),
  //     where: '$id = ?',
  //     whereArgs: [log.logId],
  //   );
  // }

  close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
