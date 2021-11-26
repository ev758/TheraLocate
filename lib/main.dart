import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thera_locate/city_therapy.dart';
import 'search.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => CityTherapy(),
      child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'TheraLocate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),

      backgroundColor: Color(0xFFD7ECE2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 20,
              child: Container(
                margin: EdgeInsets.only(top: 150),
                child: Text(
                  'Welcome to TheraLocate',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 40,
              child: Container(
                margin: EdgeInsets.only(top: 165, bottom: 230),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Search(title: 'TheraLocate')),
                      );
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Arial',
                      ),
                    ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
