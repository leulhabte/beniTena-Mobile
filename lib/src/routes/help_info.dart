import 'package:flutter/material.dart';
import '../localization/localization_value.dart';
import '../config/styling.dart';

class HelpInfo extends StatelessWidget{
  Widget build(context){
    return Scaffold(
      appBar: AppBar(title: Text(getTranslated(context, 'call')),backgroundColor: AppTheme.appColor,),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            ListTile(
              leading: Icon(Icons.call, color: AppTheme.appBackGround,size: 30,),
              title: Text('${getTranslated(context, 'call2')} 8016',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.info_outline,color: AppTheme.appColor,size: 30,),
            ),
            SizedBox(height: 20.0,),
            ListTile(
              leading: Icon(Icons.call, color: AppTheme.appBackGround,size: 30),
              title: Text('${getTranslated(context, 'call2')} 8335',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.info_outline,color: AppTheme.appColor,size: 30,),
            ),
          ],
        ),
      ),
    );
  }
}