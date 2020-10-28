import 'package:flutter/material.dart';

void main() => runApp(new Appln());

class Appln extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Re:do',
      home: TodoApp()
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  createState() => new TodoAppState();
}

class TodoAppState extends State<TodoApp> {
  List<String> _todoItems = [];

  void _addTodoItem(String task){
    setState(() {
      if(task.length!=0)_todoItems.add(task);      //placeholder generated to-do item
    });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
        itemBuilder: (context, index){
          if(index<_todoItems.length){
            return _buildTodoItem(_todoItems[index]);
          }else return null;
        }
     );
  }

  Widget _buildTodoItem(String todoText) {
    return new ListTile(
      title: Text(todoText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Re:do'),
        actions: [
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: _testDebuglogbah
          )],
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoItemScreen,
        tooltip: 'Add a new task',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoItemScreen() {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                appBar: new AppBar(
                    title: new Text('Add a new Task')
                ),
                body: new TextField(
                  autofocus: true,
                  onSubmitted: (val){
                    _addTodoItem(val);
                    Navigator.pop(context);
                  },
                  decoration: new InputDecoration(
                    hintText: 'Enter something to do...',
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              );
            }
        )
    );
  }

  void _testDebuglogbah() {
    print("test");
  } //placeholder function for future upgrades
}