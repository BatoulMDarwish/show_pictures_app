import 'package:flutter/material.dart';
import '../widgets/app_text.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? exception;

  const ErrorScreen({Key? key, this.exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppText("Error screen"),
    );
  }
}
