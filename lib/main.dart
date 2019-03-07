//imports flutter
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String nome = 'Carlos';
//imports others
void main() {
  Firestore.instance
      .collection('mensagens')
      .document()
      .collection('arqmidia')
      .document()
      .setData(data);

  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  final Widget child;

  Home({Key key, this.child}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Flutter'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[400],
      ),
      body: Column(),
    );
  }
}
