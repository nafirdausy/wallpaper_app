import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/widget.dart';

class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({this.categorieName});

  @override
  _CategoriesState createState() => _CategorieState();
}

class _CategoriesState extends State<Categorie> {
  List<WallpaperModel> wallpapers = new List();
  
  getSearchWallpaper(String query) async {
      await http.get(
          "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
          headers: {"Authorization": apiKEY}) {
        //print(value.body);

        Map<String, dynamic> jsonData = jsonDecode(value.body);
        jsonData["photos"].forEach((element) {
          //print(element);
          PhotosModel photosModel = new PhotosModel();
          photosModel = PhotosModel.fromMap(element);
          photos.add(photosModel);
          //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
        });

        setState(() {});
      };
  }

  @override
  void initState(){
    getSearchWallpaper(widget.categorieName);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 16,),
                wallpapersList(wallpapers: wallpapers, context: context)
              ]
            )
          ),
      )     
    );
 }
}