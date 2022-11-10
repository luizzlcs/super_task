import 'package:flutter/material.dart';
import 'package:super_task/components/Task.dart';
import 'package:super_task/data/task_dao.dart';
import 'package:super_task/data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  final BuildContext taskContext;
  const FormScreen({required this.taskContext, Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController pathImageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 400,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 211, 209, 209),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (valueValidator(value)) {
                        return 'Você precisa definir um nome para a Task!';
                      }
                      return null;
                    },
                    controller: nameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Nome',
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      filled: true,
                      suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {});
                          nameController.clear();
                        },
                        child: const Icon(Icons.remove_circle_outlined),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) < 1 ||
                          int.parse(value) > 5) {
                        return 'Insira uma dificuldade entre 1 e 5';
                      }
                      return null;
                    },
                    controller: difficultyController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Dificuldade',
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      filled: true,
                      suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {});
                          difficultyController.clear();
                        },
                        child: const Icon(Icons.remove_circle_outlined),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.url,
                    validator: (String? value) {
                      if (valueValidator(value)) {
                        return 'Insira uma URL de Imagem!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: pathImageController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Url da imagem',
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      filled: true,
                      suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {});
                          pathImageController.clear();
                        },
                        child: const Icon(Icons.remove_circle_outlined),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 55,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      pathImageController.text,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset('assets/images/perfil.png');
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          elevation: 0.5,
                          duration: Duration(seconds: 4),
                          content:
                              Text('Criando tarefa ${nameController.text}'),
                        ),
                      );
                      await TaskDAO().save(Task(
                        name: nameController.text,
                        pathImage: pathImageController.text,
                        difficulty: int.parse(difficultyController.text),
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Adicionar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
