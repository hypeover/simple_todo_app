import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  final List tasks;
  final Function(int, bool?) onTaskToggle;

  const TaskList({super.key, required this.tasks, required this.onTaskToggle});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          leading: SizedBox(
            width: 40,
            child: Transform.scale(
              scale: 1.6,
              child: Checkbox(
                activeColor: Colors.black,
                checkColor: Colors.white,
                side: BorderSide(color: Color(0xffe8e8e8), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: tasks[index]['isCompleted'],
                onChanged: (bool? value) {
                  onTaskToggle(index, value);
                },
              ),
            ),
          ),
          title: Text(
            tasks[index]['name'],
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              decorationColor: Color(0xffd0d0d2),
              color:
                  tasks[index]['isCompleted']
                      ? Color(0xffd0d0d2)
                      : Color(0xff737373),
              decoration:
                  tasks[index]['isCompleted']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            tasks[index]['time'],
            style: TextStyle(
              decorationColor: Color(0xffdedfe0),
              fontSize: 18,
              color:
                  tasks[index]['isCompleted']
                      ? Color(0xffdedfe0)
                      : Color(0xffa3a3a3),
              fontWeight: FontWeight.w500,
              decoration:
                  tasks[index]['isCompleted']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
            ),
          ),
        );
      },
    );
  }
}
