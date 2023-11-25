import 'package:flutter/material.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home : TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  TextEditingController taskController = TextEditingController();

  List<Task> tasks = [];

  void addTask(String title)
  {
    setState(() {
      tasks.add(Task(title: title, addedTime: DateTime.now()));
      taskController.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title : Text('Todo App'),
      ),
      backgroundColor: Colors.tealAccent,
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    hintText: 'Enter a new task',
                  ),
                ),
              ),
              IconButton(onPressed: (){
                if(taskController.text.isNotEmpty){
                  addTask(taskController.text);
                }
              }, icon: Icon(Icons.add)),
            ],
          ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text(
                    'Added: ${tasks[index].addedTime.hour}:${tasks[index].addedTime.minute}:${tasks[index].addedTime.second}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  String title;
  DateTime addedTime;

  Task({required this.title, required this.addedTime});
}