import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:intl/intl.dart';
import 'package:new_todo_app/widgets/task_tile.dart';
import './task_name.dart';
import './task_time.dart';
import './task_today.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textController = TextEditingController();
  final _timeController = TextEditingController();
  bool isToday = true;

  final _todayTasksBox = Hive.box('todayTasksBox');
  final _tomorrowTasksBox = Hive.box('tomorrowTasksBox');

  List todayTasks = [];
  List tomorrowTasks = [];

  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  title: Text(
                    'Task',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add a task',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      AddTaskButton(textController: _textController),
                      const SizedBox(height: 5),
                      TaskTime(timeController: _timeController),
                      const SizedBox(height: 15),
                      IsTodaySwitch(
                        onChanged: (value) {
                          setState(() {
                            isToday = value;
                          });
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          addTask();
                          isToday = true;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF171717),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'If you disable today, the task will be considered as a tomorrow.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF87878c),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addTask() {
    String taskName = _textController.text;
    String taskTime = _timeController.text;

    if (taskName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'Task name cannot be empty',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color(0xFF171717),
        ),
      );
      return;
    }

    setState(() {
      if (isToday) {
        todayTasks.add({
          'name': taskName,
          'time':
              taskTime.isEmpty
                  ? DateFormat('hh:mm a').format(DateTime.now())
                  : taskTime,
          'isCompleted': false,
          'isShown': true,
        });
        saveTodayTasks();
      } else {
        tomorrowTasks.add({
          'name': taskName,
          'time':
              taskTime.isEmpty
                  ? DateFormat('hh:mm a').format(DateTime.now())
                  : taskTime,
          'isCompleted': false,
        });
        saveTomorrowTasks();
      }
      _textController.clear();
      _timeController.clear();
    });
  }

  void deleteTasks() {
    setState(() {
      todayTasks =
          todayTasks.where((task) => task['isCompleted'] == false).toList();
      tomorrowTasks =
          tomorrowTasks.where((task) => task['isCompleted'] == false).toList();

      saveTodayTasks();
      saveTomorrowTasks();
    });
  }

  void saveTodayTasks() {
    _todayTasksBox.put("todayTasksBox", todayTasks);
  }

  void saveTomorrowTasks() {
    _todayTasksBox.put("tomorrowTasksBox", tomorrowTasks);
  }

  @override
  void initState() {
    todayTasks = _todayTasksBox.get('todayTasksBox') ?? [];
    tomorrowTasks = _tomorrowTasksBox.get('tomorrowTasksBox') ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f8fa),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: deleteTasks,
                      child: Text(
                        'Hide completed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff3478f6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),

                todayTasks.isEmpty
                    ? Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'No tasks added',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    : TaskList(
                      tasks: todayTasks,
                      onTaskToggle: (index, value) {
                        setState(() {
                          todayTasks[index]['isCompleted'] = value!;
                        });
                      },
                    ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tomorrow',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                TaskList(
                  tasks: tomorrowTasks,
                  onTaskToggle: (index, value) {
                    setState(() {
                      tomorrowTasks[index]['isCompleted'] = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openBottomSheet,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        backgroundColor: Colors.black,

        child: const Icon(Icons.add, color: Colors.white, size: 40),
      ),
    );
  }
}
