import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
class ImageView extends StatefulWidget {
  final String imgUrl;
  const ImageView({Key? key, required this.imgUrl}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: widget.imgUrl,
            child: SizedBox(
                height: size.height,
                width: size.width,
                child: Image.network(widget.imgUrl, fit: BoxFit.cover,)),
          ),
          Positioned(
              top: 30,
              right: 20,
              child:
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black
                    ),
                    child: const Icon(
                      Icons.close_rounded, size: 30, color: Colors.white,)),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => _save(),
                child: Container(
                  height: size.height * 0.08,
                  width: size.width * 0.5,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF83EAAF)),
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: const LinearGradient(
                          colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)]
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Set Wallpaper",
                        style: TextStyle(color: Colors.white, fontSize: 15),),
                      Text("Image will be saved in gallery",
                        style: TextStyle(color: Colors.white, fontSize: 12),),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Cancel", style: TextStyle(color: Colors.white),),
              const SizedBox(height: 40,)
            ],
          )
        ],
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,

      ].request();
    }
    else {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await[
          Permission.photos
        ].request();
      }
    }
  }
}