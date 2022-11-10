import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:super_task/components/difficulty.dart';
import 'package:super_task/data/task_dao.dart';

class Task extends StatefulWidget {
  String name;
  String pathImage;
  int difficulty;
  int level;
  int? colorTask;

  Task({
    required this.name,
    required this.pathImage,
    required this.difficulty,
    this.level = 0,
    this.colorTask,
  });

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  MaterialColor changeLevelColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 375,
            height: 115,
            decoration: BoxDecoration(
              color: changeLevelColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15, left: 10),
                  child: SizedBox(
                    width: 240,
                    height: 5,
                    child: LinearProgressIndicator(
                      color: Colors.white,
                      value: (widget.difficulty > 0)
                          ? (widget.level / widget.difficulty) / 10
                          : 0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 9, left: 60),
                  child: Text(
                    'Nível: ${widget.level}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 375,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      child: Image.network(
                        widget.pathImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(
                          widget.name,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Difficulty(difficultyLevel: widget.difficulty)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: SizedBox(
                    width: 49,
                    height: 50,
                    child: ElevatedButton(
                      onLongPress: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Você vai deletar uma tarefa'),
                            content: RichText(
                              text: TextSpan(
                                text: 'Tem certeza que quer deletar a tarefa ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${widget.name}?',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      )),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  TaskDAO().delete(widget.name);
                                  Navigator.pop(context);
                                },
                                child: const Text('Sim'),
                              ),
                            ],
                          ),
                        );

                        print('Deletando tarefa');
                      },
                      onPressed: () {
                        setState(() {
                          int fullLavel = widget.difficulty * 10;

                          widget.level < fullLavel ? widget.level++ : null;

                          double fullLavelCollorPerThree = fullLavel / 3;
                          double fullLavelCollorPerTwo =
                              fullLavelCollorPerThree * 2;

                          if (widget.level >= fullLavelCollorPerThree &&
                              widget.level < fullLavelCollorPerTwo) {
                            changeLevelColor = Colors.grey;
                          } else if (widget.level >= fullLavelCollorPerTwo &&
                              widget.level < fullLavel) {
                            changeLevelColor = Colors.deepPurple;
                          } else if (widget.level >= fullLavel) {
                            changeLevelColor = Colors.green;
                          }
                        });

                        String novaCor = changeLevelColor.toString();
                        print('QUAL É A COR? $novaCor');
                        TaskDAO().save(Task(
                          name: widget.name,
                          pathImage: widget.pathImage,
                          difficulty: widget.difficulty,
                          level: widget.level,
                        ));
                      },
                      child: Column(
                        children: const [
                          Icon(Icons.arrow_drop_up_sharp),
                          Text(
                            'Up',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
