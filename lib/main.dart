// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_api/services/service.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Upload image to api"),
            centerTitle: true,
          ),
          body: Center(
              child: MaterialButton(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                Uint8List bytes = await image.readAsBytes();
                UploadApiImage().uploadimage(bytes, image.name).then(
                  (value) {
                    setState(() {
                      print(
                          "uploaded succesfully with the link ${value.toString()}");
                    });
                  },
                ).onError((erorr, stackTrace) {
                  print(erorr.toString());
                });
              }
            },
            color: Colors.blue,
            child: const Padding(
              padding: EdgeInsets.all(1),
              child: Text("upload image"),
            ),
          )),
        ));
  }
}
