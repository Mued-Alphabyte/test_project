import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorTrackingScreen extends StatefulWidget {
  @override
  _SensorTrackingScreenState createState() => _SensorTrackingScreenState();
}

class _SensorTrackingScreenState extends State<SensorTrackingScreen> {
  List<FlSpot> gyroDataX = [FlSpot(0, 0)];
  List<FlSpot> gyroDataY = [FlSpot(0, 0)];
  List<FlSpot> gyroDataZ = [FlSpot(0, 0)];
  List<FlSpot> accelDataX = [FlSpot(0, 0)];
  List<FlSpot> accelDataY = [FlSpot(0, 0)];
  List<FlSpot> accelDataZ = [FlSpot(0, 0)];

  double gyroX = 0, gyroY = 0, gyroZ = 0;
  double accelX = 0, accelY = 0, accelZ = 0;
  final double threshold = 5.0;
  final int windowSize = 20;
  final int updateFrequency = 5;
  int gyroCounter = 0;
  int accelCounter = 0;

  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    // Listen to gyro data
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (mounted) {
        setState(() {
          gyroX = event.x;
          gyroY = event.y;
          gyroZ = event.z;

          if (++gyroCounter % updateFrequency == 0) {
            addDataToGraph(gyroDataX, gyroX);
            addDataToGraph(gyroDataY, gyroY);
            addDataToGraph(gyroDataZ, gyroZ);
            gyroCounter = 0;
          }

          checkAlert();
        });
      }
    });

    // Listen to accelerometer data
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      if (mounted) {
        setState(() {
          accelX = event.x;
          accelY = event.y;
          accelZ = event.z;

          if (++accelCounter % updateFrequency == 0) {
            addDataToGraph(accelDataX, accelX);
            addDataToGraph(accelDataY, accelY);
            addDataToGraph(accelDataZ, accelZ);
            accelCounter = 0;
          }

          checkAlert();
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel the subscriptions when the widget is disposed
    _gyroscopeSubscription?.cancel();
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void addDataToGraph(List<FlSpot> data, double value) {
    if (value.isNaN || value.isInfinite) {
      value = 0;
    }

    if (data.length >= windowSize) {
      data.removeAt(0);
    }

    double xValue = data.isNotEmpty ? data.last.x + 1 : 0;
    data.add(FlSpot(xValue, value));
  }

  void checkAlert() {
    if (gyroX.abs() > threshold && gyroY.abs() > threshold && gyroZ.abs() > threshold) {
      showAlert();
    } else if (accelX.abs() > threshold && accelY.abs() > threshold && accelZ.abs() > threshold) {
      showAlert();
    }
  }

  void showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ALERT"),
          content: const Text("High movement detected on multiple axes!"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sensor Tracking"),
      ),
      body: Column(
        children: [
          const Text("Gyro Data"),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: gyroDataX.isNotEmpty ? gyroDataX.first.x : 0,
                maxX: gyroDataX.isNotEmpty ? gyroDataX.last.x : 50,
                minY: -10,
                maxY: 15,
                titlesData: const FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: gyroDataX,
                    isCurved: true,
                    color: Colors.red,
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: gyroDataY,
                    isCurved: true,
                    color: Colors.blue,
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: gyroDataZ,
                    isCurved: true,
                    color: Colors.green,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Accelerometer Data"),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: accelDataX.isNotEmpty ? accelDataX.first.x : 0,
                maxX: accelDataX.isNotEmpty ? accelDataX.last.x : 50,
                minY: -10,
                maxY: 20,
                titlesData: const FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: accelDataX,
                    isCurved: true,
                    color: Colors.green,
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: accelDataY,
                    isCurved: true,
                    color: Colors.red,
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: accelDataZ,
                    isCurved: true,
                    color: Colors.blue,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
