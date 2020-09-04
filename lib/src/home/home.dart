import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../routes/form.dart';
import '../routes/help.dart';
import '../config/styling.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import '../routes/more.dart';
import '../classes/languages.dart';
import '../localization/localization_value.dart';
import '../app.dart';
import '../routes/help_info.dart';
import '../routes/dev.dart';

class Home extends StatefulWidget{
  int index;
  Home(this.index);
  HomeState createState()=> HomeState(index);
}

class HomeState extends State<Home>{

  int _currentIndex;

  HomeState(this._currentIndex);

  final List<Widget> _children = [
    Forms(),
    Help(),
    More(),
  ];

  @override
  void initState(){
    super.initState();
  }

  _changeLang(Language lang) async{
    Locale _temp = await setLocale(lang.langCode);
    App.setLocale(context, _temp);
  }

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'app')),
        backgroundColor: AppTheme.appColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 1.0),
            child: DropdownButton(
              onChanged: (value){
                _changeLang(value);
              },
              icon: Icon(Icons.language, color: Colors.white,),
              underline: SizedBox(),
              items: Language.languageList().map<DropdownMenuItem<Language>>((lang){
                return DropdownMenuItem(
                    value: lang,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(lang.name),
                        Text(lang.flag)
                      ],
                    ),
                );
              }).toList(),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              margin: EdgeInsets.all(0),
              accountName: Text('Powered By:'),
              accountEmail: Text('Benishangul Gumuz Region ICT Agency'),
              currentAccountPicture: CircleAvatar(
                child: Text('BT', style: TextStyle(color: Colors.white),),
                backgroundColor: AppTheme.appColor2,
              ),
              decoration: BoxDecoration(
                color: AppTheme.appColor,
              ),
            ),
            ListTile(
              title: Text(getTranslated(context, 'help')),
              leading: Icon(Icons.help, color: AppTheme.appColor),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return HelpInfo();
                }));
              },
            ),
            ListTile(
              title: Text(getTranslated(context, 'about')),
              leading: Icon(Icons.info, color: AppTheme.appColor),
            ),
            ListTile(
              title: Text(getTranslated(context, 'dev')),
              leading: Icon(Icons.help, color: AppTheme.appColor),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return DevInfo();
                }));
              },
            ),
            ListTile(
              title: Text(getTranslated(context, 'exit')),
              leading: Icon(Icons.exit_to_app, color: AppTheme.appColor),
              onTap:(){
                SystemNavigator.pop();
            }
            )

          ],
        ),
      ),
      bottomNavigationBar: BubbleBottomBar(
          opacity: .2,
          currentIndex: _currentIndex,
          onTap: (value){setState(() {
            _currentIndex = value;
          });},
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          hasNotch: true, //new
          hasInk: true,//new, gives a cute ink effect
          inkColor: Colors.black12 ,//optional, uses theme color if not specified
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(backgroundColor: AppTheme.appColor2, icon: Icon(Icons.add, color: Colors.deepPurple,), activeIcon: Icon(Icons.dashboard, color: Colors.indigo,), title: Text(getTranslated(context, 'add'))),
            BubbleBottomBarItem(backgroundColor: AppTheme.appColor, icon: Icon(Icons.help, color: Colors.deepPurple,), activeIcon: Icon(Icons.info_outline, color: Colors.indigo,), title: Text(getTranslated(context, 'prev'))),
            BubbleBottomBarItem(backgroundColor: AppTheme.appColor, icon: Icon(Icons.more, color: Colors.deepPurple,), activeIcon: Icon(Icons.cloud, color: Colors.indigo,), title: Text(getTranslated(context, 'moreTab')))
          ],
    ),
      body: _children[_currentIndex],
    );
  }
}