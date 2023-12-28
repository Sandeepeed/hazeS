import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hazes/views/imageview.dart';

import '../model/wallpapermodel.dart';

Widget wallpapersList(List<WallpaperModel> wallpapers, context)
{
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
    childAspectRatio: 0.6,
    mainAxisSpacing: 6.0,
    crossAxisSpacing: 6.0,
    children: wallpapers.map((e){
      return GridTile(child:
      GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(imgUrl: e.src!.portrait!)));
        },
        child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(e.src!.portrait!,fit: BoxFit.cover,)),
        ),
      ));
    }).toList(),
    ),
  );
}