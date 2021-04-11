
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dress_container.dart';
import 'seller_input.dart';
import 'dress_model.dart';
import 'package:fit_finder/dress_model.dart' as alpha;
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  alpha.Dress dress;

  MyHomePage({this.dress});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    alpha.Dress dress;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 75, left: 25, right: 20),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                  iconSize: 25,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute
                      (builder: (context) => SellerInput(dress: Dress()))
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Shop for',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            //SizedBox(height: 05,),
            Text(
              'Day Dresses',
              style: TextStyle(fontSize: 40),
            ),
            Dress_Container(),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.home),
                Icon(Icons.favorite),
                Icon(Icons.shopping_basket),
                Icon(Icons.person),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
