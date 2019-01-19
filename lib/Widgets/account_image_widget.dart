import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

String imagePath = "img/imagePath.png";

class AccountImage extends StatefulWidget {
  @override
  _AccountImageState createState() => _AccountImageState(); 
}

class _AccountImageState extends State<AccountImage> {
  
  imageSelectorGallery() async {
    final File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (imageFile != null) imagePath = imageFile.path;
    });
  }

  imageSelectorCamera() async {
    final File imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (imageFile != null) imagePath = imageFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        iconSize: 150,
        icon: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: AssetImage(imagePath),radius: 75),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => SimpleDialog(
              children: <Widget> [ 
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take picture"),
                  onTap: () async {
                    Navigator.of(context).pop();
                    imageSelectorCamera();
                  },
              ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Pick from gallery"),
                  onTap: () async {
                    Navigator.of(context).pop();
                    imageSelectorGallery();
                  },
                ),
            ]),
          );
        },
      ),
    );
  }
}
