import 'package:fit_finder/medium_size_input.dart';
import 'package:fit_finder/large_size_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dress_model.dart';
import 'package:fit_finder/small_size_input.dart';

class SellerInput extends StatefulWidget {
  Dress dress;

  SellerInput({this.dress});

  @override
  _SellerInputState createState() => _SellerInputState(dress);
}

class _SellerInputState extends State<SellerInput> {

  GlobalKey<FormState> _key = GlobalKey();
  bool _autoValidate = false;
  Dress dress;

  _SellerInputState(this.dress);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Seller Input',
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _key,
                autovalidate: _autoValidate,
                child: FormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration:
            InputDecoration(hintText: 'Description of Garment line1'),
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            onSaved: (val) {
              widget.dress.dressName = val;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration:
            InputDecoration(hintText: 'Description Of Garment line2 '),
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Price'),
            onSaved: (val) {
              widget.dress.price = val;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Display Image URL'),
            onSaved: (val) {
              widget.dress.imageURL = val;
            },
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SmallScreenInput(),
                    ),
                  );
                },
                child: Text(
                  'SMALL',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MediumScreenInput(),
                    ),
                  );
                },
                child: Text(
                  'MEDIUM',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LargeScreenInput(),
                    ),
                  );
                },
                child: Text(
                  'LARGE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 20,),
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      OpenAlert();
                    },
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black,
                  ),
                ]),
          )
        ]);
  }

  Future<void> OpenAlert() async{
    return showDialog(
        context: this.context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Success!"),
            content: SingleChildScrollView(
              child: ListBody(
                  children:<Widget>[
                    Text("Successfully Submitted"),
                  ]
              ),
            ),
          );
        }
    );
  }
}
