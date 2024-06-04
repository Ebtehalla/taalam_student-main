import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}
