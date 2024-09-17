import 'package:flutter/material.dart';
import 'package:test_app/Util/tools.dart';
import 'package:test_app/sensor_page.dart';

import 'LocalDatabase/data_fetching_and_setup.dart';
import 'ToDo/ToDoList.dart';
import 'Util/color_code.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}


class _StartPageState extends State<StartPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tableGenerator();
  }

  Future<void> generateTable() async {
    await tableGenerator();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  navigateTo(context, const Todolist());
                },
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(18), // Adjust the radius as needed
                  ),
                  child: const Center(
                    child: Text(
                      'A To Do List',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: (){
                  navigateTo(context, SensorTrackingScreen());
                },
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18), // Adjust the radius as needed
                  ),
                  child: const Center(
                    child: Text(
                      'Sensor Tracking',
                      style: TextStyle(
                          color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
