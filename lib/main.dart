import 'package:flutter/material.dart';
import 'package:rotation_champs/pages/home_page.dart';
import 'package:rotation_champs/pages/champ_detail_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Champion Rotation',
      initialRoute: '/',
      routes:{
        '/': (BuildContext context)=>HomePage(),
        'detalle':(BuildContext context)=> ChampionDetailPage(),
      }
    );
  }
}