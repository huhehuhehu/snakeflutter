import 'package:flutter/material.dart';
import './SnakeEngine.dart';
import './highscores.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  final SharedPreferences storage = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    home: MyApp(storage),
  ));
}

class MyApp extends StatelessWidget {
  SharedPreferences storage;
  // This widget is the root of your application.
  MyApp(this.storage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQIMwQCrpKNkt3T2zDzuyGYEGdx8sRLf6p3hQ&usqp=CAU'),
            fit: BoxFit.fitWidth,
    ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Snaky SNAKE SNAKE",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                MaterialButton(
                  child: Text("New Game",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  color: Color(0xFFFFFF),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SnakeEngine(storage)),
                    );
                  },
                ),
                MaterialButton(
                  child: Text("HIGHSCORES",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  color: Color(0xFFFFFF),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => highscores(storage)),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
