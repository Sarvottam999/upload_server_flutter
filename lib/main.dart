import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:my_app/api.dart';
import 'package:my_app/tag_fiel.dart';

void main() {
  // runApp(temp());
  runApp(MaterialApp(
        title: "wellcome",
        // home: Home()));
        home: temp()));
}

class temp extends StatefulWidget {
  @override
  State<temp> createState() => _tempState();
}

class _tempState extends State<temp> {
  void _handleURLButtonPress(BuildContext context, var type) {}

  File? thumbnails;
  File? video;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.thumbnails = imageTemp);
      print(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickVideo() async {
    try {
      final image = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.video = imageTemp);
      print(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Image Picker Example"),
            ),
            body: Center(
              child: Column(
                children: [
// -------------------------------  select image button ------------------------------------

                  MaterialButton(
                      color: Colors.blue,
                      child: const Text("Pick Image from Gallery",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        pickImage();
                      }),
// -------------------------------  select video button ------------------------------------

                  MaterialButton(
                      color: Colors.blue,
                      child: const Text("Pick video from Camera",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        pickVideo();
                      }),
// -------------------------------  upload button ------------------------------------

                  MaterialButton(
                      color: Color.fromARGB(255, 243, 33, 33),
                      child: const Text("upload",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        try {
                          api().uploadImage(
                              video: video!, thumbnails: thumbnails!);
                        } catch (e) {
                          print(e);
                        }
                      }),
                ],
              ),
            )));
  }
}
