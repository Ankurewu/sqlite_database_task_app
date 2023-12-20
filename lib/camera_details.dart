import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OpenCameraScreen extends StatefulWidget {
  @override
  State<OpenCameraScreen> createState() => _OpenCameraScreenState();
}

class _OpenCameraScreenState extends State<OpenCameraScreen> {
  File? _selectedImage;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Camera",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              color: Colors.blue,
                onPressed: () {  
                _pickImagefromcamera();
                },
                child:Text(
                  "Take a Picture",
                  style: TextStyle(color: Colors.white),
                ),
            
              ),
              MaterialButton(
              color: Colors.deepPurple,
                onPressed: () {   
                _pickImagefromgallery(); 
                },
                child:Text(
                  "Pick from gallery",
                   style: TextStyle(color: Colors.white) ,
                ),
            
              ),
              SizedBox(height: 20,),
              _selectedImage != null?Image.file(_selectedImage!): Text("Please select an image")
          ],
        ),
      ),

    );
  }
  Future _pickImagefromgallery()async {

    final returnedImage= await ImagePicker().pickImage(source: ImageSource.gallery);
    if 
    (returnedImage==null) return;
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
Future _pickImagefromcamera()async {

    final returnedImage= await ImagePicker().pickImage(source: ImageSource.camera);
    if 
    (returnedImage==null) return;
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
}

