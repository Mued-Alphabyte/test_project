import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String title;
  final int index;

  const CustomListItem({
    super.key,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.list,
          color: Colors.teal,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          '$index',
          style: const TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
