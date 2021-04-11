import 'package:fit_finder/dress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fit_finder/dress_model.dart';
import 'package:fit_finder/dress_model.dart' as alpha;

class Dress_Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView.builder(
        itemCount: dress.length,
        itemBuilder: (BuildContext context, int index) {
          alpha.Dress beta = dress[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder:(_)=>DressScreen(dress:beta)
              ),
            ),
            child: Container(
              width: 270,
              margin: EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                            color: Colors.black26,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: beta.imageURL,
                            child: ClipRRect(
                              child: ClipRRect(
                                child: Image(
                                  height: 450,
                                  image: AssetImage(beta.imageURL),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 15.0,
                            bottom: 20.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      beta.dressname,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0,
                                          letterSpacing: 1.2),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      beta.dressName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0,
                                          letterSpacing: 1.2),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      '\$${beta.price}.99',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 55),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(Icons.favorite_border,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
