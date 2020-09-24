import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Todoey/screens/homepage.dart';
import 'models/task_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todoey',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
            accentColor: Colors.blueAccent, primaryColor: Colors.blueAccent),
        home: HomePage(),
      ),
    );
  }
}
