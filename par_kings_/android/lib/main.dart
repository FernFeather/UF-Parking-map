import 'package:flutter/material.dart';
import 'package:par_kings/screens/search.dart';
 
void main() {
  runApp(const MyApp()); // starts everyhing
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Par-Kings',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:Search()
    );
  }
}
