//imports flutter
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//imports others
void main() async {
  runApp(MyApp());
}

//definindo os temas
final ThemeData KIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);

final ThemeData KDefaultTheme =
    ThemeData(primarySwatch: Colors.purple, accentColor: Colors.orange[400]);

class MyApp extends StatelessWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Flutter',
      theme: Theme.of(context).platform == TargetPlatform.iOS
          ? KIOSTheme
          : KDefaultTheme,
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Widget child;

  ChatScreen({Key key, this.child}) : super(key: key);

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat App'),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(),
      ),
    );
  }
}
