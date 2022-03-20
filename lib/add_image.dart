import 'dart:io';
import 'package:findmydog/breed_result.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tflite/tflite.dart';
import 'add_image.dart';




class AddImage extends StatefulWidget {

  static String id = 'add_image';

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool pick;


  bool _isLoading;
  XFile _image;
  List _output;

  String _confidence="";
  double _percentage;
  String _name="";
  String numbers="";

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loadModel().then((value){
  //     setState(() {
  //       // _isLoading=false;
  //     });
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ListTile(
          leading: Icon(
            FontAwesomeIcons.listUl,
            color: Colors.black,
          ),
          title: Text(
            'Screen 2',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      // body: isLoading?Container(
      //   alignment: Alignment.center,
      //   child: CircularProgressIndicator(),
      // ):Container(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //
      //       imagee==null?Container():Image.file(File(imagee.path)),
      //       SizedBox(height: 16,),
      //       outputt == null? Text(""):Text("${outputt[0]["label"]}",
      //         style: TextStyle(
      //             color: Colors.black
      //         ),)
      //     ],
      //   ),
      // ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only( top:50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: FlatButton(
                      child: Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                      color: Colors.black,
                      onPressed: () async{
                        await chooseImage(ImageSource.camera);
                        pick = true;




                        // chooseImage();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => BreedResult(
                        //     pic: pick,
                        //     padam: _image,
                        //     vivaranam: _output,
                        //     peru:_name,
                        //     confidenceInd:_confidence,
                        //     shatamanam:_percentage,
                        //   ),
                        // ));
                      },
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black,
                    onPressed: () async{
                      await loadModel().then((value){
                        setState(() {
                          // _isLoading=false;
                        });
                      });
                      pick = false;
                      // chooseImage();
                      await chooseImage(ImageSource.gallery);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => BreedResult(
                      //     pic: pick,
                      //     padam: _image,
                      //     vivaranam: _output,
                      //     peru:_name,
                      //     confidenceInd:_confidence,
                      //     shatamanam:_percentage,
                      //   ),
                      // ));
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 100.0),

            (_image==null) ? Container(alignment: Alignment.center,
                height: 200.0,
                width: 200.0,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent)
                ),
                child: Column(
                  children: [
                    Text('My Awesome Border'),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: CircularProgressIndicator(

                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                ):
            // _isLoading?Container(
            //   alignment: Alignment.center,
            //   child: CircularProgressIndicator(
            //     color: Colors.black,
            //   ),):
            SafeArea(
              child: Container(child:Image.file(File(_image.path),fit: BoxFit.cover,),
                height: 200.0,
                width: 200.0,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent)
                ),
              ),
            ),

            FlatButton(
              child: Text(
                "Get Result",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.black,
              onPressed: () async{

                // await loadModel().then((value){
                //   setState(() {
                //     // _isLoading=false;
                //   });
                // });
                // pick = false;
                // // chooseImage();
                // await chooseImage(ImageSource.gallery);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BreedResult(
                    pic: pick,
                    padam: _image,
                    vivaranam: _output,
                    peru:_name,
                    confidenceInd:_confidence,
                    shatamanam:_percentage,
                  ),
                ));
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: Center(
      //   child: FlatButton(
      //
      //     child: Text("Gallery",
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),),
      //     color: Colors.black,
      //
      //
      //
      //
      //     onPressed: (){
      //       pick = false;
      //       // chooseImage();
      //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BreedResult(pic: pick,),));
      //     },
      //   ),
      // ),
    );
  }

  loadModel() async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt");

  }

  chooseImage(ImageSource source) async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile image = await _picker.pickImage(source: source);
    if(image ==null) return null;
    setState(() {
      _isLoading=true;
      _image= image ;
    });
    await runModelOnImage(image);
  }

  runModelOnImage(XFile image) async{
    var output= await Tflite.runModelOnImage(path: image.path,
        numResults: 2,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5);

    setState(() {
      _isLoading=false;
      _image=image;
      _output=output ;
      String str =_output[0]["label"];
      _name=str.substring(2);
      _confidence=_output!=null?(_output[0]['confidence']*100.0).toString().substring(0,2)+"%":"";
      _percentage=_output!=null?(_output[0]['confidence']):"";
    });

  }
}
