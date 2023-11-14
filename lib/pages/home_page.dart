// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_v1/data/database.dart';
import 'package:todo_v1/util/dilog_box.dart';
import 'package:todo_v1/util/todo_tile.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    //if first time opening app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //they already exists data
      db.loadData();
    }

    // TODO: implement initState
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChange(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  void SaveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void AddNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DilogBox(
          controller: _controller,
          onSave: SaveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TO DO'), elevation: 0, actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: AddNewTask,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        height: 40,
        color: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return todoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChange(value, index),
            deleteAction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
