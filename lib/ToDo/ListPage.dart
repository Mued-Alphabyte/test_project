import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/LocalDatabase/local_database_handler.dart';
import 'package:test_app/ToDo/ListPage2.dart';
import 'package:test_app/Util/color_code.dart';
import 'package:test_app/Util/tools.dart';

import '../Provider/to_do_provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  LocalDatabaseHandler handler = LocalDatabaseHandler();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Lists', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Untitled List (0)',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              style: const TextStyle(fontSize: 20),
              controller: controller,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 15, // This will adjust the padding based on keyboard height
          left: 10,
          right: 10,
        ),
        child: GestureDetector(
          onTap: () async {

            if(controller.text.isNotEmpty){
              print("click");
              int id = await handler.insertList(controller.text);
              await todoProvider.getList1();


              navigateReplacement(context, ListPage2(text: controller.text, id: id));

            }else{
              showToastInfo("Please Enter List Name");
            }

          },
          child: Card(
            color: buttonColor,
            margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            elevation: 15,
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              child: const Text(
                "ADD",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
