import 'package:flutter/material.dart';
import '../localization/localization_value.dart';
import '../config/styling.dart';

class DevInfo extends StatelessWidget{
  Widget build(context){
    return Scaffold(
      appBar: AppBar(title: Text('Developers Info'),backgroundColor: AppTheme.appColor,),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              ListTile(
                leading: Icon(Icons.account_circle, color: AppTheme.appBackGround,size: 30,),
                title: Text('${getTranslated(context, 'dev1')}',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                subtitle: Text('leulh63@gmail.com',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal)),
                trailing: Icon(Icons.android,color: AppTheme.appColor,size: 20,),
              ),
              SizedBox(height: 20.0,),
              ListTile(
                leading: Icon(Icons.account_circle, color: AppTheme.appBackGround,size: 30,),
                title: Text('${getTranslated(context, 'dev2')}',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                subtitle: Text('mehiretab333@gmail.com',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal)),
                trailing: Icon(Icons.android,color: AppTheme.appColor,size: 20,),
              ),
              SizedBox(height: 20.0,),
              ListTile(
                leading: Icon(Icons.account_circle, color: AppTheme.appBackGround,size: 30,),
                title: Text('${getTranslated(context, 'dev3')}',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                subtitle: Text('aronikakume1996@gmail.com',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal)),
                trailing: Icon(Icons.android,color: AppTheme.appColor,size: 20,),
              ),
              SizedBox(height: 20.0,),
              ListTile(
                leading: Icon(Icons.account_circle, color: AppTheme.appBackGround,size: 30,),
                title: Text('${getTranslated(context, 'dev4')}',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                subtitle: Text('alulabirhanu7@gmail.com',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal)),
                trailing: Icon(Icons.android,color: AppTheme.appColor,size: 20,),
              ),
              SizedBox(height: 20.0,),
            ],
          ),
        ),
      ),
    );
  }
}