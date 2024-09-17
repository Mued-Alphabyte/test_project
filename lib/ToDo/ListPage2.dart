import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/LocalDatabase/local_database_handler.dart';
import 'package:test_app/Util/color_code.dart';
import 'package:test_app/Util/tools.dart';

import '../Provider/to_do_provider.dart';

class ListPage2 extends StatefulWidget {
  final String text;
  final int id;
  const ListPage2({super.key, required this.text, required this.id});

  @override
  State<ListPage2> createState() => _ListPage2State();
}

class _ListPage2State extends State<ListPage2> {

  LocalDatabaseHandler handler = LocalDatabaseHandler();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.text;
  }

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
            todoProvider.getList1();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                widget.text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              ),
            )
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

            int count = await handler.deleteList(widget.id);
            await todoProvider.getList1();
            if(count>0){
              Navigator.pop(context);
            }


          },
          child: Card(
            color: buttonColor,
            margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            elevation: 15,
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              child: const Text(
                "DELETE TASK",
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
