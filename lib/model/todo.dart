class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required  this.todoText,
    this.isDone = false
  }); 

  static List<ToDo> todoList() {
    return[
      ToDo(id: '01', todoText: 'Morning Exercise'),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Coocking'),
      ToDo(id: '04', todoText: 'Check Work Email'),
      ToDo(id: '05', todoText: 'Check lark card', isDone: true),
      ToDo(id: '06', todoText: 'Take a bath', isDone: true),
      ToDo(id: '07', todoText: 'Taking lunch'),
    ];
  }
}