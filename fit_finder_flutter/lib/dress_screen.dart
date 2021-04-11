import 'package:fit_finder/camera_input.dart';
import 'package:fit_finder/dress_model.dart';
import 'package:flutter/material.dart';

class DressScreen extends StatefulWidget {
  @override
  final Dress dress;
  DressScreen({this.dress});

  _DressScreenState createState() => _DressScreenState();
}

class _DressScreenState extends State<DressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Hero(
                tag: widget.dress.imageURL,
                child: ClipRRect(
                  child: Image(
                    image: AssetImage(widget.dress.imageURL),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 25),
                        Icon(
                          Icons.shopping_basket,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 500),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 440,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Women',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Print Tee',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '\$159.99',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'This is a beautiful women print tee for your daily look, this tee is trendy meets...                 More',
                    style: TextStyle(letterSpacing: 0.6),
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 55,
                    child: Flexible(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            child: Text('Select Size'),
                          ),
                          SizedBox(width: 15),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    height: 45,
                                    width: 100,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {},
                                      child: Text(
                                        'XS',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.grey,
                                            width: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {},
                                      child: Text(
                                        'S',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.grey,
                                            width: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {},
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      elevation: 10,
                                      shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.white,
                                            width: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {},
                                      child: Text(
                                        'L',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.grey,
                                            width: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: RaisedButton(
                      elevation: 10.0,
                      onPressed:() {
                        Navigator.of(context).push(MaterialPageRoute
                          (builder: (context) => CameraInput(dress: Dress()))
                        );
                      },
                      color: Colors.black,
                      child: Text(
                        'Find your Fit',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// String id='1';
//  String getIDOfDress(dress){
//    return dress.ID;
//  }
}

