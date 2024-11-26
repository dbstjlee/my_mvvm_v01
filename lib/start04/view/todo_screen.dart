import 'package:flutter/material.dart';
import 'package:my_mvvm_v01/start02/models/todo.dart';
import 'package:my_mvvm_v01/start04/view_models/todo_view_model.dart';
import 'package:provider/provider.dart';

// MaterialApp 앱 안에서 외부 라이브러리(Provider) 위젯을 감싸 주어야 한다.
void main() => runApp(
      MaterialApp(
        //  (_) => TodoViewModel() -> 매개변수를 사용 안 할꺼면 _를 선언한다.
        home: ChangeNotifierProvider(
          create: (_) => TodoViewModel(),
          builder: (context, child) {
            return TodoScreen();
          },
        ),
      ),
    );

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVVM provider Todo List'),
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
                    // 여기에서 뷰 모델 클래스를 가져오자 --> DI 처리
                    final todoViewModel =
                        Provider.of<TodoViewModel>(context, listen: false);
                    if (_controller.text.isNotEmpty) {
                      todoViewModel.addTodo(_controller.text);
                      _controller.clear();
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
            child: Consumer<TodoViewModel>(
              builder: (context, todoViewModel, child) {
                return ListView.builder(
                    itemCount: todoViewModel.todos.length,
                    itemBuilder: (context, index) {
                      // 뷰모델에 있는 자료구조 안에 각 인덱스에 맵핑된 객에 todo인스턴스 하나
                      final todo = todoViewModel.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: IconButton(
                          onPressed: () => todoViewModel.removeTodo(todo.id),
                          icon: Icon(Icons.delete),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
