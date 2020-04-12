import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _taskController = TextEditingController();

  List _toDoList = [];
  Map<String, dynamic> _taskRemoved;
  int _taskRemovedIndex;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addTask() {
    setState(() {
      Map<String, dynamic> newTask = Map();
      newTask['title'] = _taskController.text;
      _taskController.text = '';
      newTask['completed'] = false;
      _toDoList.insert(0, newTask);
      _saveData();
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<Void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((task1, task2) {
        if (task1['completed'] && task2['completed']) {
          return 0;
        }

        return task1['completed'] ? 1 : -1;
      });
    });

    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                        labelText: 'Nova Tarefa',
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                RaisedButton(
                  child: Text('ADD'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: _addTask,
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  itemCount: _toDoList.length,
                  padding: EdgeInsets.only(top: 10),
                  itemBuilder: buildItem),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Align(
            alignment: Alignment(-.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white)),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]['title']),
        value: _toDoList[index]['completed'],
        secondary: CircleAvatar(
          child:
              Icon(_toDoList[index]['completed'] ? Icons.check : Icons.error),
        ),
        onChanged: (bool value) {
          setState(() {
            _toDoList[index]['completed'] = value;
            _saveData();
          });
        },
      ),
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      onDismissed: (direction) {
        setState(() {
          _taskRemoved = Map.from(_toDoList[index]);
          _taskRemovedIndex = index;
          _toDoList.removeAt(index);
          _saveData();

          final snack = SnackBar(
            content: Text('Tarefa \"${_taskRemoved["title"]}\"removida!'),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                setState(() {
                  _toDoList.insert(_taskRemovedIndex, _taskRemoved);
                  _saveData();
                });
              },
            ),
          );

          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }
}
