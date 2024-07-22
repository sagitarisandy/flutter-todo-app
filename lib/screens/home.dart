import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constans/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo =todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: todosList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notes_rounded,
                            color: tdGrey,
                            size: 60,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Try to type and add your Todo',
                            style: TextStyle(
                              fontSize: 15,
                              color: tdGrey
                            ),
                          ),
                          Container(
                          margin: EdgeInsets.only(
                            bottom: 80
                          ),
                        )
                        ],
                      ),
                  )

                  : ListView(
                      children: [

                        //nama All todos
                        Container(
                          margin: EdgeInsets.only(
                            top:50,
                            bottom:20,
                          ),
                          child: Text(
                            'All ToDos',
                            style:TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: tdBlack,
                            )
                          ),
                        ),
                        
                        //menampilkan list todo item
                        for ( ToDo todo in _foundTodo.reversed)
                        TodoItem(
                          todo: todo,
                          onToDoChange: _handleToDoChange,
                          onDeleteItem: _handleDeleteToDo,
                        ),

                        //margin bawah list todo item
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 80
                          ),
                        )
                      ],
                    ),
                )
                
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 10,
                    left: 15,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(
                      color: Color.fromARGB(142, 158, 158, 158),
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    )],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add new todo item',
                      hintStyle: TextStyle(color: tdGrey),
                      border: InputBorder.none
                    ),
                  )
                ),
              ),
              Container(
                margin:EdgeInsets.only(
                  bottom: 20,
                  right: 15
                ),
                child: ElevatedButton(
                  child: Text('+', style: TextStyle(fontSize: 40, color: Colors.white),),
                  onPressed: () {
                    if (_todoController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('To-do item cannot be empty')
                        ),
                      );
                    } else{
                      _addToDoItem(_todoController.text);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Success adding new item')
                      //   ),
                      // );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    )
                  )
                ),
              )
            ],),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  
  void _handleDeleteToDo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty){
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase())) 
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20, 
            maxWidth: 25
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.png'),
          ),
        ),
      ],),
    );
  }
  
}