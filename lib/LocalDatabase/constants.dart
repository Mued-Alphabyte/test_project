final databaseTables = {
  "TODO":
      "CREATE TABLE IF NOT EXISTS TODO (ID INTEGER PRIMARY KEY AUTOINCREMENT, desc TEXT, titleID INTEGER, isDone INTEGER);",
  "LIST":
  "CREATE TABLE IF NOT EXISTS LIST (ID INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT);"
};
