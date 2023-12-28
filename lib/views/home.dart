import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hazes/data/data.dart';
import 'package:hazes/views/category.dart';
import 'package:hazes/views/search.dart';
import 'package:hazes/widgets/textWidget.dart';
import 'package:hazes/widgets/wallpapertile.dart';
import 'package:http/http.dart' as http;
import '../model/categories.dart';
import '../model/wallpapermodel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageNo = 1;
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();
  String apiKey = "563492ad6f917000010000016d549683924c48caaf534be1e7a5edb5";
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  ScrollController scrollController = ScrollController();

  getTrendingWallpapers() async {
    var response = await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/curated?page=$pageNo&per_page=10",
        ),
        headers: {
          "Authorization": apiKey,
        });
    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  loadMore() async {
    isLoading = true;
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      pageNo += 1;
      getTrendingWallpapers();
    }
    isLoading = false;
  }

  @override
  void initState() {
    categories = getCategories();
    // TODO: implement initState
    scrollController = ScrollController()
      ..addListener(() {
        loadMore();
      });
    getTrendingWallpapers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: brandName(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
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
                  children: [
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchWallpaper(
                                        searchQuery: _controller.text,
                                      )));
                        },
                        child: const Icon(Icons.search)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width,
                height: size.height * 0.06,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoriesDisplay(
                                        searchQuery: categories[index]
                                            .categoriesName!)));
                          },
                          child: CategoriesTile(
                              imgUrl: categories[index].imageUrl!,
                              text: categories[index].categoriesName!));
                    }),
              ),
              wallpapersList(wallpapers, context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl;
  final String text;
  const CategoriesTile({Key? key, required this.imgUrl, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Hero(
            tag: imgUrl,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imgUrl,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: size.width * 0.25,
              height: size.height * 0.08,
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
