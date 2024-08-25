// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'dialog_copy_receive.dart';

class TimerDialog extends StatefulWidget {
  const TimerDialog({super.key});

  @override
  _TimerDialogState createState() => _TimerDialogState();
}

class _TimerDialogState extends State<TimerDialog> {
  @override
  void initState() {
    super.initState();
    _startAutoCloseTimer();
  }

  void _startAutoCloseTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogCopyReceive(onPressed: () => Navigator.pop(context));
  }
}
