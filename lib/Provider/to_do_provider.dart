import 'package:flutter/cupertino.dart';
import 'package:test_app/LocalDatabase/local_database_handler.dart';

class ToDoProvider extends ChangeNotifier{

  LocalDatabaseHandler handler = LocalDatabaseHandler();

  late List<Map<String, dynamic>> topList = [];

  Future<void> getList1() async {
    List<Map<String, dynamic>> data = await handler.fetchListData();
    if (data.isNotEmpty) {

      topList = data;
      // print("Address "+address.first['ADDRESS']);
    }
    else{
      topList = [];
      print("Empty");
    }

    notifyListeners();

  }

}