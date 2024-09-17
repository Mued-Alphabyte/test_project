
import 'constants.dart';
import 'local_database_handler.dart';

Future<void> tableGenerator() async {
  final LocalDatabaseHandler localDatabaseHandler = LocalDatabaseHandler();
  await localDatabaseHandler.initDatabase();

  for (var key in databaseTables.keys) {
    try {
      await localDatabaseHandler
          .doesTableExist(tableName: key)
          .then((value) async {
        if (!value) {
          await localDatabaseHandler.createTable(
              sqlInject: databaseTables[key]!);
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}