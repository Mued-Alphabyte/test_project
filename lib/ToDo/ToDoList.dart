import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Provider/to_do_provider.dart';
import 'package:test_app/ToDo/ListPage.dart';
import 'package:test_app/ToDo/ListPage2.dart';
import 'package:test_app/Util/color_code.dart';
import 'package:test_app/Util/tools.dart';

import 'Widget/CustomListItem.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context, listen: false);
    todoProvider.getList1();
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Card(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  elevation: 10,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.white,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.black.withOpacity(0.5),
                            ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Abdulla Al Med",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                      ),
                    ),
                    Text(
                        "5 incomplete, 5 complete",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Consumer<ToDoProvider>(builder: (BuildContext context, ToDoProvider value, Widget? child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: value.topList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        navigateTo(context, ListPage2(text: value.topList[index]["title"], id: value.topList[index]["ID"]));
                      },
                      child: CustomListItem(
                        title: value.topList[index]["title"],
                        index: index + 1, // Incremented to display 1, 2, 3, etc.
                      ),
                    );
                  },
                ),
              );
            },)
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () {
              navigateTo(context, const ListPage());
              print('FAB Pressed');
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: buttonColor,
            child: Container(
              margin: EdgeInsets.all(15),
                child: const Icon(Icons.add,color: Colors.white,)
            ), // Customize the color
          ),
        )
      ),
    );
  }
}
