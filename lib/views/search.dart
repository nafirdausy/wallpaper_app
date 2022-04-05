import 'dart:ffi';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget{
  final String searchQuery;
  Search({this.searchQuery});

  @override 
  _SearchState createState() => _SearchState();

}

class _SearchState extends State<Search>{
  
List<WallpaperModel> wallpapers = new List();
TextEditingController searchController = new TextEditingController();

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
    getSearchWallpaper(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
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
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "search wallpaper",
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          getSearchWallpaper(searchController.text);
                        },
                        child: Container(
                          child: Icon(Icons.search)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                wallpapersList(wallpapers: wallpapers, context: context)
              ]
            )
          ),
      )     
    );
  }
}