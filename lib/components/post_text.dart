//import 'dart:convert'; //將未使用到的檔案註解
import 'package:flutter/material.dart';
//import 'package:flutter_book_remote_example/models/post.dart';  //將未使用到的檔案註解
import 'package:flutter_application_2/daos/post_dao.dart';

class PostText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PostDao.getPosts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<dynamic>> asyncSnapshot) {
          List<Widget> widgets = [];
          print(asyncSnapshot.connectionState);
          print(asyncSnapshot.hasData);

          if (asyncSnapshot.connectionState == ConnectionState.done) {
            widgets = asyncSnapshot.requireData.map((post) {
              return Text(post.toJsonObjectString());
            }).toList();
          }

          return SingleChildScrollView(
            child: Column(children: widgets),
          );
        });
  }
}
