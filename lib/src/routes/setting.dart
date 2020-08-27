import 'package:flutter/material.dart';
import '../config/size_config.dart';

class Settings extends StatefulWidget{
 SettingsState createState()=> SettingsState();
}

class SettingsState extends State<Settings>{

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: _buildBody(),
    );
  }

  // ignore: missing_return
  Widget _buildBody(){
    Orientation orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.portrait){
      return Container(
        height: SizeConfig.blockSizeVertical*100,
        width: SizeConfig.blockSizeHorizontal*100,
        color: Colors.green,
        child: LayoutBuilder(builder: (context, constraint){
          return ListView(
            children: [
              _buildMenuItem(constraint)
            ],
          );
        },)
      );
    }else if(orientation == Orientation.landscape){
      return Container(
        height: SizeConfig.blockSizeHorizontal*100,
        width: SizeConfig.blockSizeVertical*100,
        color: Colors.blue,
          child: LayoutBuilder(builder: (context, constraint){
            return ListView(
              children: [
                _buildMenuItem(constraint)
              ],
            );
          },)
      );
    }
  }

  Widget _buildMenuItem(BoxConstraints constraints){
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.language),
          title: Text('Change Language'),
          onTap: ()=> _buildDialoge(constraints)
    ),
      ],
    );
  }

  _buildDialoge(BoxConstraints constraints){
    return showDialog(
        context: context,
        builder: (context){
          String language = 'English';
          return AlertDialog(
            title: Text('Language'),
            content: StatefulBuilder(
              builder: (context, setState){
                return Container(
                  height: constraints.maxHeight*0.18,
                  width: constraints.maxWidth*0.4,
                  child: Column(
                    children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text('English')),
                        Radio(
                          groupValue: language,
                          value: 'English',
                          onChanged: (value){
                            setState(() {
                              language = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text('Amharic')),
                        Radio(
                          groupValue: language,
                          value: 'Amharic',
                          onChanged: (value){
                            setState(() {
                              language = value;
                            });
                          },
                        ),
                      ],
                    )
                    ],
                  ),
                );
              },
            ),
            actions: [
              FlatButton(
                child: Text('ok'),
                onPressed: (){
                  print(language);
                },
              )
            ],
          );
        }
    );
  }
}