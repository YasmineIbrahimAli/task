import 'package:flutter/material.dart';

class PasswordVeraction extends StatelessWidget {
  final String text;
  final bool isMet;
  const PasswordVeraction(this.text, this.isMet, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: isMet ? Colors.green : Colors.grey,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
