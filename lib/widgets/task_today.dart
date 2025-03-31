import 'package:flutter/material.dart';

class IsTodaySwitch extends StatefulWidget {
  const IsTodaySwitch({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  State<IsTodaySwitch> createState() => _IsTodaySwitchState();
}

class _IsTodaySwitchState extends State<IsTodaySwitch> {
  bool isToday = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Today',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 20),
        Switch(
          value: isToday,
          onChanged: (bool value) {
            setState(() {
              isToday = value;
            });
            widget.onChanged(value);
          },
          activeTrackColor: Color(0xFF171717),
        ),
      ],
    );
  }
}
