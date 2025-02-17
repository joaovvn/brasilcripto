import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdatedAtWidget extends StatelessWidget {
  const UpdatedAtWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Updated at ${DateFormat('HH:mm').format(DateTime.now())}",
        textAlign: TextAlign.end,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600));
  }
}
