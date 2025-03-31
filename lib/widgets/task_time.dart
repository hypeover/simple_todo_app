import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bottom_picker/bottom_picker.dart';

class TaskTime extends StatelessWidget {
  const TaskTime({super.key, required TextEditingController timeController})
    : _timeController = timeController;

  final TextEditingController _timeController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Hour',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: BottomPicker.time(
            use24hFormat: false,
            closeIconSize: 0,
            pickerTextStyle: TextStyle(fontSize: 20),
            onChange:
                (time) => {
                  _timeController.text =
                      DateFormat.jm().format(time).toString(),
                },
            height: 75,
            titleAlignment: Alignment.topCenter,
            backgroundColor: Colors.transparent,
            displaySubmitButton: false,
            displayCloseIcon: false,
            pickerTitle: Text(''),
            initialTime: Time(),
          ),
        ),
      ],
    );
  }
}
