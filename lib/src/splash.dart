import 'package:flutter/material.dart';
import 'home/menu.dart';
import 'package:splashscreen/splashscreen.dart';
import './config/styling.dart';
import './localization/localization_value.dart';

class Splash extends StatefulWidget{
  SplashState createState()=> SplashState();
}

class SplashState extends State<Splash>{

  initState(){
    super.initState();
  }

  Widget build(context){
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Menus(),
      image: Image.asset('assets/image/stopcorona.png'),
      title: Text(getTranslated(context, 'welcome'), style: TextStyle(fontSize: 20),),
      backgroundColor: Colors.white,
      photoSize: 100.0,
      loaderColor: AppTheme.appColor,
    );
  }
}