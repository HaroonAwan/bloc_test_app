import 'package:flutter/material.dart';

/// A confirmation dialog which appears to take permission from the user that he wants to perform the action or not
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.body,
    this.title = 'Alert!',
  });

  final String body;
  final String title;

  Future<bool> show(BuildContext context) async {
    return (await showDialog<bool?>(
          context: context,
          builder: (_) => this,
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
