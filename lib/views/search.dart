import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hazes/widgets/textWidget.dart';
import 'package:http/http.dart' as http;

import '../model/wallpapermodel.dart';
import '../widgets/wallpapertile.dart';

class SearchWallpaper extends StatefulWidget {
  final String searchQuery;
  const SearchWallpaper({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchWallpaper> createState() => _SearchWallpaperState();
}

class _SearchWallpaperState extends State<SearchWallpaper> {

  String apiKey = "563492ad6f917000010000016d549683924c48caaf534be1e7a5edb5";
  List<WallpaperModel> wallpapers = [];

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
  _controller.text = widget.searchQuery;
  super.initState();
  }
 final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: brandName(),
        leading:GestureDetector(
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
              child: Row(
                children:  [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: (){
                        wallpapers = [];
                        getSearchWallpapers(_controller.text);
                      },
                      child: Icon(Icons.search)),
                ],
              ),
            ),
             const SizedBox(height: 20,),
            wallpapersList(wallpapers, context),
          ],
        ),
      ),
    );
  }
}
