import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '���� ���θ���Ʈ',
      theme:  ThemeData(primarySwatch: Colors.blue),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget{
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

  class TodoItem{
    String  title;
    bool isCompleted;
    bool isImportant;

    TodoItem({
      required this.title,
      this.isCompleted = false,
      this.isImportant = false,
    });
  }

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItem> todos = [];

  TextEditingController textController = TextEditingController();

  void addTodo(){
    String newTodo = textController.text.trim();

    if (newTodo.isNotEmpty) {
      setState(() {
              todos.add(TodoItem(title: newTodo));
            });
            textController.clear;
    }
  }
    void deleteCompleted(){
    setState(() {
          todos.removeWhere((todo) => todo.isCompleted);
        });
        }

  void deleteAll(){
    setState(() {
          todos.removeWhere((todo) => todo.isCompleted);
          todos.removeWhere((todo) => !todo.isCompleted);
        });
  }
  void deleteTodo(int index) {
    setState(() {
          todos.removeAt(index);
        });
  }
  void toggleTodo(int index) {
    setState(() {
          todos[index].isCompleted = !todos[index].isCompleted;
        });
  }
  int get completedCount{
    return todos.where((todo) => todo.isCompleted).length;

  }
  int get uncompletedCount{
    return todos.where((todo) => !todo.isCompleted).length;
  }

  @override
  void dispose(){
    textController.dispose();
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('���� ���θ���Ʈ'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: '�� �� �Է� ',
                      filled:true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => addTodo(),
                  ),
                ),

                SizedBox(width: 10),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: addTodo,
                  child: Text('+', style: TextStyle(color : Colors.blue, fontSize: 30)),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: deleteAll,
                  child: Text('-', style: TextStyle(color : Colors.red, fontSize: 30)),
                ),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: deleteCompleted,
                  child: Text('-', style: TextStyle(color : Colors.green, fontSize: 30)),
                ),

              ],
            ),
          ),

          

          Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('��ü', todos.length, Colors.blue),
                _buildStatItem('�Ϸ�', completedCount, Colors.green),
                _buildStatItem('�̿Ϸ�', uncompletedCount, Colors.orange),
              ],
            ),
          ),

          Expanded(
            child: todos.isEmpty
            ?Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                  size: 100,color: Colors.grey[300]),
                 SizedBox(height: 20),
                 Text(
                  '�� ���� �����',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[500],
                  ),
                 ),
                ],
              ),
            )
            :ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: todos.length,
              itemBuilder: (context, index){
                final todo = todos[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) => toggleTodo(index),
                      activeColor: Colors.green,
                      ),
                title: Text(
                  todo.title,
                  style: TextStyle(fontSize: 18,
                  decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  :TextDecoration.none,
                  color: todo.isCompleted
                  ? Colors.grey
                  : Colors.black,
                  ),
                ),
                trailing:IconButton(
                  icon: Icon(Icons.delete, color:Colors.red),
                  onPressed: () => deleteTodo(index),
                  ),
                  ),
                  );
                }
                ),
          ),
        ],
      ),
    );
  }
  Widget _buildStatItem(String label, int count, Color color){
    return Column(
      children: [
        Text(
          '$count',
          style:  TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14,color: Colors.grey[600]),
        )
      ],
    );
  }
}
