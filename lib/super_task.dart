import 'package:flutter/material.dart';
import 'package:super_task/data/task_inherited.dart';
import 'package:super_task/screens/initial_screen.dart';
import 'package:super_task/theme/my_theme.dart';

class SuperTask extends StatelessWidget {
  const SuperTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      home: TaskInherited(
        child: InitialScreen(),
      ),
    );
  }
}
