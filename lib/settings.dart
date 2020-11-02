import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:re_do/ThemeWork.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child){
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: Padding(padding: EdgeInsets.all(8.0),
            child: ListView.builder(itemCount: 1,itemBuilder: (BuildContext context, int index){
              return Card(
                child: SwitchListTile(
                  title: Text(appState.isDark?'Light mode':'Dark mode'),
                  value: appState.isDark?true:false,
                  onChanged: (value)=> Provider.of<AppStateNotifier>(context, listen: false).switchTheme('darkSwitch'),
                  secondary: Icon(Icons.palette, color: appState.isDark?Colors.white:Colors.black,),
                ),
              );
            }),
          ),
        );
      }
    );
  }
}