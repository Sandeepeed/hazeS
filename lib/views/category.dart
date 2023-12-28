import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../model/wallpapermodel.dart';
import '../widgets/textWidget.dart';
import '../widgets/wallpapertile.dart';
class CategoriesDisplay extends StatefulWidget {
  final String searchQuery;
  const CategoriesDisplay({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<CategoriesDisplay> createState() => _CategoriesDisplayState();
}

class _CategoriesDisplayState extends State<CategoriesDisplay> {
  List<WallpaperModel> wallpapers = [];
  String apiKey = "563492ad6f917000010000016d549683924c48caaf534be1e7a5edb5";
  getSearchWallpapers(String query)async{
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=20"),
        headers:
        {
          "Authorization" : apiKey,
        }
    );
    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element){
      // print(element);
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    getSearchWallpapers(widget.searchQuery);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: brandName(),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF83EAAF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
            ),
            const SizedBox(height: 20,),
            wallpapersList(wallpapers, context),
          ],
        ),
      ),
    );
  }
}
