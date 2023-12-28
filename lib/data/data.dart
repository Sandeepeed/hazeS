import '../model/categories.dart';

List<CategoriesModel> getCategories(){
  String apiKey = "563492ad6f917000010000016d549683924c48caaf534be1e7a5edb5";
  List<CategoriesModel> categories =  [];
  CategoriesModel categoriesModel =  CategoriesModel();
categoriesModel.imageUrl = "https://images.pexels.com/photos/11643390/pexels-photo-11643390.jpeg?cs=srgb&dl=pexels-mo-eid-11643390.jpg&fm=jpg";
categoriesModel.categoriesName = "3D art";
categories.add(categoriesModel);
categoriesModel = CategoriesModel();

  categoriesModel.imageUrl = "https://images.pexels.com/photos/1529360/pexels-photo-1529360.jpeg?cs=srgb&dl=pexels-vlad-che%C8%9Ban-1529360.jpg&fm=jpg";
  categoriesModel.categoriesName = "Rain";
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imageUrl = "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?cs=srgb&dl=pexels-stein-egil-liland-3408744.jpg&fm=jpg";
  categoriesModel.categoriesName = "Nature";
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();


  categoriesModel.imageUrl = "https://images.pexels.com/photos/2156881/pexels-photo-2156881.jpeg?cs=srgb&dl=pexels-anni-roenkae-2156881.jpg&fm=jpg";
  categoriesModel.categoriesName = "Abstract";
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();


  categoriesModel.imageUrl = "https://images.pexels.com/photos/45170/kittens-cat-cat-puppy-rush-45170.jpeg?cs=srgb&dl=pexels-pixabay-45170.jpg&fm=jpg";
  categoriesModel.categoriesName = "Animals";
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();


  return categories;

}