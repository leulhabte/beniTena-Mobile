import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async{
  await DotEnv().load('.env');
  runApp(MyApp());
}

Widget MyApp(){
  return App();
}