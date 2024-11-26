
// todo의 모델 클래스 - 할 일 데이터를 정의
class Todo {

  final String id;
  final String title;

  // 객체가 메모리에 올라갈 때 null이 될 수 없음
  Todo({required this.id, required this.title});
}