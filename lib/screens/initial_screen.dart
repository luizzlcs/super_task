import 'package:flutter/material.dart';
import 'package:super_task/components/Task.dart';
import 'package:super_task/data/task_dao.dart';
import 'package:super_task/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
          future: TaskDAO().findAll(),
          builder: ((context, snapshot) {
            List<Task>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Carregando...')
                    ],
                  ),
                );

              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                      Text('Carregando...')
                    ],
                  ),
                );
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando...')
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Task tarefa = items[index];
                          return tarefa;
                        });
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.error_outline_outlined,
                          size: 128,
                        ),
                        Text(
                          'Não há nenuma tarefa!',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return const Text('Erro ao carregar Taferas!');
            }
            return const Text('Erro desconhecido!');
          }),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        shape:  CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.amberAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (newContext) => FormScreen(taskContext: context),
            ),
          ).then((context) => setState(() {
                debugPrint('Recarregando a tela inicial');
              }));
        },
        tooltip: 'Nova tarefa',
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        splashColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
