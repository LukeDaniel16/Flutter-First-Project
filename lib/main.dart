import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {    
  // This widget is the root of your application.
  @override    
  Widget build(BuildContext context) {    
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IF Acadêmico',      
      theme: new ThemeData(                        
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
       primaryColor: Colors.green,
       accentColor: new Color(0xff25D366),
      ),            
      home: MyHomePage(title: "IF Acadêmico Offline"),
       routes: <String, WidgetBuilder> {
              '/horariotela': (BuildContext context) => new HorarioScreen(),
              '/agendatela': (BuildContext context) => new AgendaScreen(),
              '/saudetela': (BuildContext context) => new SaudeScreen(),
              '/listcursotela': (BuildContext context) => new CursoScreen(),                  
           },
    );
  }
}

class MyHomePage extends StatefulWidget {  
  MyHomePage({Key key, this.title}) : super(key: key);    
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;  
  @override  
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {      
  String textValue = 'Hello World';
  final FirebaseMessaging _messaging = FirebaseMessaging();  
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();  
  @override     
  void initState() {
    super.initState();           
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');    
    _messaging.configure(
      onLaunch: (Map<String, dynamic> msg){
        print(" onLaunch called");
      },
      onResume: (Map<String, dynamic> msg){
        print(" onResume called");
      },
      onMessage: (Map<String, dynamic> msg){
        print(" onMessage called");
      },
    );
    _messaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true
      )
    );
    _messaging.onIosSettingsRegistered.listen((IosNotificationSettings setting){
      print('IOS Setting Registed');
    });
    _messaging.getToken().then((token){
      update(token);
    });
  } 
  update(String token){
    print(token);
    textValue = token;
    setState(() {
          
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(        
        child: new Center(                    
        child: new Column(          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LogoIF(),
            new Text(
              'Escolha uma opção:',              
              textAlign: TextAlign.right,
              textScaleFactor: 2.0,
              overflow: TextOverflow.clip,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            new RaisedButton(
              child: new Text('HORÁRIOS DE AULA', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              color: Theme.of(context).primaryColor,
              elevation: 4.0,
              splashColor: Colors.white,
              onPressed: (){
                Navigator.pushNamed(context, "/horariotela");            
              }
            ),
            new RaisedButton(
              child: new Text('AGENDA DE EVENTOS', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              color: Theme.of(context).primaryColor,
              elevation: 4.0,
              splashColor: Colors.white,
              onPressed: (){
                Navigator.pushNamed(context, "/agendatela");            
              }
            ),
            new RaisedButton(
              child: new Text('SAÚDE', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              color: Theme.of(context).primaryColor,
              elevation: 4.0,
              splashColor: Colors.white,
              onPressed: (){     
                Navigator.pushNamed(context, "/saudetela");            
              }
            ),
            new RaisedButton(
              child: new Text('LISTA DE CURSOS', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              color: Theme.of(context).primaryColor,
              elevation: 4.0,
              splashColor: Colors.white,
              onPressed: (){              
                   Navigator.pushNamed(context, "/listcursotela");
              }
                // Perform some action
            ),            
          ],
        ),
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class LogoIF extends StatelessWidget{
  @override
  Widget build(BuildContext context) {    
    AssetImage assetImage = AssetImage('images/logomorrinhos.png');
    Image image = Image(image: assetImage);
    return Container(child: image, width: 225, height: 225,);
  }
}
class CursoScreen extends StatelessWidget{
  @override
    Widget build(BuildContext context){
      return Scaffold(
     appBar: AppBar(             
        title: Text('Lista de Cursos'),
        
        ),
       );
    }
}
class SaudeScreen extends StatelessWidget{
  @override
    Widget build(BuildContext context){
      return Scaffold(
     appBar: AppBar(
        title: Text('Saúde'),
        ),
       );
    }
}
class AgendaScreen extends StatelessWidget{
  @override
    Widget build(BuildContext context){
      return Scaffold(
     appBar: AppBar(
        title: Text('Agenda de Eventos'),
        ),
       );
    }
}
class HorarioScreen extends StatelessWidget{
  @override
    Widget build(BuildContext context){
      return Scaffold(
     appBar: AppBar(
        title: Text('Horários de Aula'),
        ),
       );
    }
}