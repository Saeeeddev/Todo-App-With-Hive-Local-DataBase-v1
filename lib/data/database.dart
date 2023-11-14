import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todoList = [];
  // refrence our box

  final _mybox = Hive.box('mybox');

// first time opening app
  void createInitialData() {
    todoList = [
      ['Go to gym', false],
      ['Clean the room', false],
    ];
  }

  //load the data from database

  void loadData() {
    todoList = _mybox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    _mybox.put("TODOLIST", todoList);
  }
}
