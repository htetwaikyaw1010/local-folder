import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../../config/master_config.dart';

class MasterAppDatabase {
  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  // PsAppDatabase._() {
  //   if (_dbOpenCompleter == null) {
  //     _dbOpenCompleter = Completer<Database>();
  //     // Calling _openDatabase will also complete the completer with database instance
  //     _openDatabase();
  //   }
  // }

  factory MasterAppDatabase() {
    return _singleton;
  }

  MasterAppDatabase._internal();

  // Singleton instance
  // static final PsAppDatabase _singleton = PsAppDatabase._();
  static final MasterAppDatabase _singleton = MasterAppDatabase._internal();

  // Singleton accessor
  static MasterAppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database>? _dbOpenCompleter;

  // Database object accessor
  Future<Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    // ignore: unnecessary_null_comparison
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer<Database>();
      // Calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter!.future;
  }

  Future<dynamic> _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();
    await appDocumentDir.create(recursive: true);
    // Path with the form: /platform-specific-directory/demo.db
    final String dbPath = join(appDocumentDir.path, MasterConfig.app_db_name);

    final Database database = await databaseFactoryIo.openDatabase(dbPath);
    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter!.complete(database);
  }
}
