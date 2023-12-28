class WallpaperModel{
  String? photographer;
  String? photographerURL;
  SrcModel? src;

  WallpaperModel({this.photographer,this.src,this.photographerURL});

  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData)
  {
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographer: jsonData['photographer'],
      photographerURL: jsonData['photographerURL'],
    );
  }
}


class SrcModel{
  String? original;
  String? small;
  String? portrait;
  SrcModel({this.portrait,this.original,this.small});
  factory SrcModel.fromMap(Map<String, dynamic> jsonData)
  {
    return SrcModel(
      portrait: jsonData["portrait"],
      original: jsonData["original"],
      small: jsonData["small"],
    );
  }
}
