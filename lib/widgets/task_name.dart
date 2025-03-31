import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
    required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Name',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: _textController,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: 'Task name',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFe4e5e7)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF171717)),
              ),
              hintStyle: TextStyle(color: Color(0xFFc3c4c7), fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
