import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // Todo기능을 개발하기 위해 필요한 데이터는 뭘까?
  // UI 로직 : 프로젠테이션 로직(화면에 있어야 함)
  final TextEditingController _controller = TextEditingController();

  // 데이터 : 할 일을 (목록을) 저장하는 리스트(저장 공간)
  List<String> todos = [];

  // 비즈니스 로직 : 할 일을 추가하는 기능(add)
  void addTodo() {
    // 자료구조에 접근해서 사용자가 넣은 데이터를 추가하는 기능
    // 비어있지 않다면 코드 실행
    if (_controller.text.isNotEmpty) {
      // 프로젠테이션 로직
      setState(() {
        todos.add(_controller.text); // 불러오면 자료구조에 들어감
        print('todos 확인 : ${todos.toString()}');
      });
      _controller.clear(); // 프로젠테이션 로직(화면 로직)
    }
  }

  // 비즈니스 로직 : 할 일을 삭제하는 기능(remove)
  void removeTodo(int index) {
    // 자료구조에 접근해서 해당 항목을 삭제하는 기능
    // 삭제할 인덱스가 필요함
    // 삭제 처리
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Todo List'),
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
                  onPressed: addTodo,
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
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index]),
                    trailing: IconButton(
                      onPressed: () {
                        // 비즈니스 로직 호출
                        removeTodo(index);
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

