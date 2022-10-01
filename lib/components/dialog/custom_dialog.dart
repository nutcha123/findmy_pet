import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget child;
  const CustomDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
