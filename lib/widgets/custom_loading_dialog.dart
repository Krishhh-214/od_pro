import 'package:flutter/material.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String message;

  const CustomLoadingDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 20),
          Text(message),
        ],
      ),
    );
  }
}
