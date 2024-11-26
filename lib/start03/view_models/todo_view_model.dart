
// ViewModel 클래스 - 상태와 로직을 담당 한다.

import 'package:flutter/material.dart';
import 'package:my_mvvm_v01/start03/models/todo.dart';

// ChangeNotifier 상속 한다.
class TodoViewModel extends ChangeNotifier {

  // 데이터가 필요하다.
  List<Todo> todos = [];

  // 할 일을 추가하는 기능
  void addTodo(String title) {
    final newTodo = Todo(id: DateTime.now().toString(), title: title);
    todos.add(newTodo);
    // 상태 알림 호출
    notifyListeners();
  }

  // 할 일을 삭제하는 기능
  void removeTodo(String id) {
    todos.removeWhere( (todo) => todo.id == id);
    // UI에 상태가 변경되었다고 알림
    notifyListeners();
  }

}
