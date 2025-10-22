import 'package:flutter/material.dart';

class NotSubscribedView extends StatelessWidget {
  final VoidCallback onSubscribe;

  const NotSubscribedView({super.key, required this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSubscribe,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text("Subscribe", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
