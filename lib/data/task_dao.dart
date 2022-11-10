import 'package:flutter/material.dart';
import 'package:super_task/components/Task.dart';
import 'package:super_task/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDAO {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER,'
      '$_image TEXT,'
      '$_lavel INTEGER)';

  static const String _tablename = 'tarefas2';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';
  static const String _lavel = 'lavel';

  // Salvando os dados
  save(Task tarefa) async {
    debugPrint('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExist = await find(tarefa.name);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExist.isEmpty) {
      debugPrint('A tarefa não existe.');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      debugPrint('A tarefa já existe');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.name],
      );
    }
  }

  //Procurando todos os dados
  Future<List<Task>> findAll() async {
    print('Acessando findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(mapaDeTarefas: result);
  }

  // Convertendo o Map para Lista
  List<Task> toList({required List<Map<String, dynamic>> mapaDeTarefas}) {
    debugPrint('Convertendo to List');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
          name: linha[_name],
          pathImage: linha[_image],
          difficulty: linha[_difficulty],
          level: linha[_lavel]);
      tarefas.add(tarefa);
    }
    debugPrint('Lista de tarefas $tarefas');
    return tarefas;
  }

  // Convertendo o objeto tarefa para mapa
  Map<String, dynamic> toMap(Task tarefa) {
    debugPrint('Convertendo tarefa em MAP');
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.name;
    mapaDeTarefas[_difficulty] = tarefa.difficulty;
    mapaDeTarefas[_image] = tarefa.pathImage;
    mapaDeTarefas[_lavel] = tarefa.level;
    debugPrint('Mapa de tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  // Fazendo uma busca utilizando a clausula where
  Future<List<Task>> find(String nomeDaTarefa) async {
    debugPrint('Acessando o find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    debugPrint('Tarefa encontrada: ${toList(mapaDeTarefas: result)}');

    return toList(mapaDeTarefas: result);
  }

  // Deletando tarefa.

  delete(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}
