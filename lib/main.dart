//imports flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

//imports others
void main() async {
  runApp(MyApp());
}

//definindo os temas
final ThemeData KIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);

final ThemeData KDefaultTheme = ThemeData(
    primarySwatch: Colors.purple, accentColor: Colors.orangeAccent[400]);

final googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance;

//função que verifica se o usuario está online ou faca o login
Future<Null> _ensureLoggedIn() async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) user = await googleSignIn.signInSilently();
  if (user == null) user = await googleSignIn.signIn();
  if (await auth.currentUser() == null) {
    GoogleSignInAuthentication credentials =
        await googleSignIn.currentUser.authentication;
    await auth.signInWithGoogle(
        idToken: credentials.idToken, accessToken: credentials.accessToken);
  }
}

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
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[ChatMessage(), ChatMessage(), ChatMessage()],
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}

//criando o campo de texto
class TextComposer extends StatefulWidget {
  final Widget child;

  TextComposer({Key key, this.child}) : super(key: key);

  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: TextField(
                decoration:
                    InputDecoration.collapsed(hintText: 'Enviar uma Mensagem'),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _isComposing ? () {} : null,
                    )
                  : IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _isComposing ? () {} : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

//definindo o balão de mensagem com foto de perfil
class ChatMessage extends StatelessWidget {
  final Widget child;

  ChatMessage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'http://www.sclance.com/pngs/avatar-png/avatar_png_70864.jpg'),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Guilherme',
                  style: Theme.of(context).textTheme.subhead,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text('teste'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
