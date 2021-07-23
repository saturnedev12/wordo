import 'package:flutter/material.dart';
import 'package:wordo/UI/home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '';
void main() async{
  await Hive.initFlutter();
  await Hive.openBox('WORDS');
  await Hive.box('WORDS').add({
    'english_note': "for the teste",
    'french_note': "pour le teste"
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
