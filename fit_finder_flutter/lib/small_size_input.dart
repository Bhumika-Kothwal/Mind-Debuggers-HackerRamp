import 'package:async/async.dart';
import 'package:fit_finder/dress_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'dress_model.dart';
import 'dress_model.dart';

class SmallScreenInput extends StatefulWidget {
  @override
  _SmallScreenInputState createState() => _SmallScreenInputState();
}

class _SmallScreenInputState extends State<SmallScreenInput> {
  @override
  File small_size;
  final picker=ImagePicker();

  // Function to open a camera
  Future openCamera() async {
    var cameraImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      small_size = File(cameraImage.path);
    });
  }

  // Function to open a local gallery
  Future openGallery() async {
    var galleryImage =
    await picker.getImage(source: ImageSource.gallery);
    setState(() {
      small_size = File(galleryImage.path);
    });
  }

  Widget build(BuildContext context) {
    //final Dress id = ModalRoute.of(context).settings.arguments;

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: this.context,
        builder: (BuildContext context)
        {
          Future.delayed(Duration(seconds: 5),() {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Alert!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Hold Camera at a distance of 95-100 cms away'),
                  Text('Contrast background is preferred'),
                ],
              ),
            ),
          );
        },
      );
    }

    Future<void> OpenAlert(String respStr) async{
      return showDialog(
          context: this.context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Here is your result"),
              content: SingleChildScrollView(
                child: ListBody(
                    children:<Widget>[
                      Text("Successfully Uploaded"),
                    ]
                ),
              ),
            );
          }
      );
    }


    uploadImageToServer(File imageFile,String id) async {
      print("attempting to connect to server......");
      var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      print(length);

      var uri = Uri.parse('http://55fcaa73bf57.ngrok.io/add_garment');
      print("connection established.");
      var request = new http.MultipartRequest("POST", uri);
      //request.fields['ID']=id;
      var multipartFile = new http.MultipartFile('small_size', stream, length,
          filename: basename(imageFile.path));

      //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      request.fields['ID']='2';
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(respStr);
      setState(() {
        Navigator.pop(this.context);
      });
      //print(respStr);
      OpenAlert(respStr);

    }

    Future<void> openDialogBox() async {
      return showDialog<void>(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(),
            backgroundColor: Colors.blue,
            title: Text(
              'Choose options',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  MaterialButton(
                    color: Colors.black,
                    child: Text(
                      "Open Camera",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _showMyDialog();
                      Future.delayed(const Duration(milliseconds: 4500), () {
                        setState(() {
                          openCamera();
                        });
                      });
                    },
                  ),
                  MaterialButton(
                    color: Colors.black,
                    child: Text(
                      "Open Gallery",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      openGallery();
                    },
                  ),
                  MaterialButton(
                    color: Colors.blue[900],
                    child: Text(
                      "upload",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      uploadImageToServer(small_size,'2');
                      print("button pressed");
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Camera Input"),
      ),
      body: Container(
        child: small_size == null
            ? Center(
          child: Text(
            "click or upload a picture",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
            : Image.file(small_size),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          openDialogBox();
        },
        backgroundColor: Colors.black,


        child: Icon(Icons.add_a_photo),
      ),
    );
  }

}
