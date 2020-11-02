import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:re_do/AppTheme.dart';
import 'ThemeWork.dart';

void main() {
  runApp(ChangeNotifierProvider<AppStateNotifier>(
    create: (context) => AppStateNotifier(),
    child: Appln(),
));
}

class Appln extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
        builder: (context, appState, child){
          return MaterialApp(
              title: 'Re:do',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: appState.isDark? ThemeMode.dark : ThemeMode.light,
              home: TodoApp()
          );
        }
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  TodoAppState createState() => new TodoAppState();
}

class TodoAppState extends State<TodoApp> {
  List<String> _todoItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(     //TODO: revamp normal appbar to floating appbar
        title: Text('Re:do'),
        actions: [
          IconButton(icon: Icon(Icons.edit),tooltip: 'edit',onPressed: ()=>_switchToEditMode()),
          IconButton(icon: Icon(Icons.more_vert),tooltip: 'options',onPressed:  ()=>_switchTheme()),    //TODO: popup/dropdown menu for changing settings
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
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child){
        return new ListTile(
          title: Text(todoText),
          onTap: ()=>appState.isEdit?_testDebuglogbah("tapped "+todoText):_testDebuglogbah("edit "+todoText),   //TODO: entry card revamp
          onLongPress: ()=>appState.isEdit?_testDebuglogbah("LongPressed "+todoText):null,
          trailing: appState.isEdit?IconButton(icon: Icon(Icons.delete), color: Colors.red,onPressed: ()=>_confirmRemoveItem(index)):null,
        );
      }
    );
  }

  void _addTodoItem(String task){
    setState(() {
      if(task.length!=0)_todoItems.add(task);
    });
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
            FlatButton(onPressed: (){_removeTodoItem(index);Navigator.of(context).pop();}, child: Icon(Icons.delete_rounded, color: Colors.red,),),
          ]
        );
      }
    );
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _switchToEditMode() {
    Provider.of<AppStateNotifier>(context, listen:false).switchEditMode();
  }

  void _switchTheme() {
    Provider.of<AppStateNotifier>(context, listen:false).switchTheme('darkSwitch');
  }

  void _testDebuglogbah(String testext) {
    print(testext);
  } //placeholder function for future upgrades
}