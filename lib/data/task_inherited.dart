import 'package:flutter/material.dart';
import 'package:super_task/components/Task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task(
        difficulty: 1,
        name: 'Estudar Flutter a todo o vapor e com muita dedicação!',
        pathImage:
            'https://cdn-images-1.medium.com/max/1024/0*vowtRZE_wvyVA7CB'),
    Task(
        difficulty: 1,
        name: 'Cozinhar',
        pathImage:
            'https://cdn.panelinha.com.br/post/1531337804516-abre-temp-post.jpg'),
    Task(
        difficulty: 2,
        name: 'Devoção Matina',
        pathImage:
            'https://somosdecristo.com.br/wp-content/uploads/2018/11/oracao-antes-ler-biblia.png'),
    Task(
        difficulty: 4,
        name: 'Ir para academia',
        pathImage:
            'https://www.biofisic.com.br/wp-content/uploads/2019/06/estereotipos-de-academia.png'),
    Task(
        difficulty: 1,
        name: 'Andar de bicicleta',
        pathImage:
            'https://cataratasdoiguacu.com.br/blog/wp-content/uploads/2020/10/IMG_3198-1024x673.jpg'),
    Task(
        difficulty: 2,
        name: 'Estudar Dart',
        pathImage:
            'https://dkrn4sk0rn31v.cloudfront.net/uploads/2022/04/PHP-ORIENTACAO-OBJETOS-400x280.png'),
    Task(
        difficulty: 5,
        name: 'Limpar a casa',
        pathImage: 'https://www.rbsdirect.com.br/imagesrc/15135835.jpg?w=700'),
  ];

  void newTask(String name, int difficulty, String pathImage) {
    taskList.add(
      Task(name: name, pathImage: pathImage, difficulty: difficulty),
    );
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldTask) {
    return oldTask.taskList.length != taskList.length;
  }
}
