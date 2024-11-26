import 'package:flutter/material.dart';
import 'package:my_mvvm_v01/start02/view_models/todo_view_model.dart';

void main() => runApp(MaterialApp(home: TodoScreen()));

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // MVVM 패턴이기 때문에 View 는 ViewModel 클래스만 참조하면 된다.
  final TodoViewModel todoViewModel = TodoViewModel();
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVVM Basic Todo List'),
      ),
      body: Column(
        children: [
          // 입력 필드 만들기
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: '작업을 입력하시오'),
                  ),
                ),
                IconButton(
                  // 매개변수로 함수 연결함(함수 호출X)
                  // (함수에 매개변수가 있었다면 () {} 형태여야 함)
                  onPressed: () {
                    // 프레젠테이션 로직
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        todoViewModel.addTodo(_controller.text);
                      });
                    }
                  },
                  icon: Icon(Icons.add),
                )
              ],
            ),
          ),
          // 아래에 할 일 목록 표시 구성
          // 정적 : ListView();
          // 동적 : ListBuilder()
          Expanded(
            child: ListView.builder(
                itemCount: todoViewModel.todos.length,
                itemBuilder: (context, index) {
                  // 뷰모델에 있는 자료구조 안에 각 인덱스에 맵핑된 객에 todo인스턴스 하나
                  final todo = todoViewModel.todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          todoViewModel.removeTodo(todo.id);
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
