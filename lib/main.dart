import 'package:flutter/material.dart';

void main() => runApp(new Appln());

class Appln extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Re:do',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyanAccent,
      ),
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
  var _isEditMode = false;

  void _addTodoItem(String task){
    setState(() {
      if(task.length!=0)_todoItems.add(task);      //placeholder generated to-do item
    });
  }

  Widget _buildTodoList() {
    return new ListView.separated(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.06),
        itemCount: _todoItems.length,
        itemBuilder: (context, index){
          if(index<_todoItems.length){
            return _buildTodoItem(_todoItems[index], index);
          }else return null;
        },
        separatorBuilder: (context, index){
          return Divider();
        },
     );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: Text(todoText),
      onTap: ()=>_testDebuglogbah("tapped "+todoText),
      onLongPress: ()=>_isEditMode?_confirmRemoveItem(index):null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Re:do'),
        actions: [
          IconButton(icon: Icon(Icons.edit),onPressed: ()=>_switchToEditMode()),
          IconButton(icon: Icon(Icons.more_vert),onPressed:  ()=>_testDebuglogbah("more button pressed")),
        ],
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoItemScreen,
        tooltip: 'Add a new task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoItemScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(title: Text('Add a new Task')),
                body: TextField(
                  autofocus: true,
                  onSubmitted: (val){
                    _addTodoItem(val);
                    Navigator.pop(context);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter something to do...',
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              );
            }
        )
    );
  }

  void _confirmRemoveItem(int index){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: Text('Remove ${_todoItems[index]}?'),
          actions: <Widget>[
            FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('CANCEL')),
            FlatButton(onPressed: (){_removeTodoItem(index);Navigator.of(context).pop();}, child: Icon(Icons.delete_rounded)),
          ]
        );
      }
    );
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _switchToEditMode() {
    _isEditMode = !_isEditMode;
  }
  void _testDebuglogbah(String testext) {
    print(testext);
  } //placeholder function for future upgrades
}