import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  ImagePicker image = ImagePicker();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            child:CircleAvatar(
              radius: 500,
              backgroundColor: Colors.white,
              child: SizedBox(
                width: 50,
                height: 50,
                child: file == null
                    ? const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.black,
                )
                    : Image.file(
                  file!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Column(
              // child: Container(
              //   padding: const EdgeInsets.all(20),
              //   color: Colors.green,
              //   child: const Icon(Icons.camera),
              // ),
              children: <Widget>[
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.black,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Please choose"),
                        content: const Text("From:"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              PermissionStatus cameraStatus = await Permission.camera.request();
                              if (cameraStatus == PermissionStatus.granted) {
                                getCam(ImageSource.camera);
                              } else if (cameraStatus == PermissionStatus.denied) {
                                return;
                              }
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text("Camera"),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              PermissionStatus cameraStatus = await Permission.storage.request();
                              if (cameraStatus == PermissionStatus.granted) {
                                getGall(ImageSource.gallery);
                              } else if (cameraStatus == PermissionStatus.denied) {
                                return;
                              }
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text("Gallery"),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text("Cancel"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Text(
            "GROUP 5",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Text(
            "Final Project",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          )
        ],

      ),
    );
  }

  getCam(ImageSource source) async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  getGall(ImageSource source) async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

}
