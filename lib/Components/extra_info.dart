import 'package:flutter/material.dart';

class ExtraInfo extends StatelessWidget {
  IconData icons;
  String texts;
  String value;
  ExtraInfo({super.key, required this.value, required this.icons, required this.texts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Icon(
            icons,
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(value,
              style: const TextStyle(
                color: Colors.white,
              ),),
          const SizedBox(
            height: 8,
          ),
          Text(
            texts,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
