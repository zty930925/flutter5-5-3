//目的：將List<Post>中的每筆post資料轉換成Json格式

//導入dart:convert，用於處理Json的編碼與解碼
import 'dart:convert';
import 'package:flutter_application_2/models/post.dart';
import 'package:flutter/material.dart';

//建立一個類別函數叫PostTable並繼承StatelessWidget
class PostTable extends StatelessWidget {
  //建立一個List<Post>，之後要進行畫面渲染，必須要有資料，故設此變數
  //後續用於建構子，之後他人使用時，必須給予一個List<Post>
  List<Post> posts;
  //建構一個函數叫做PostTable
  //用來接收資料
  PostTable(this.posts);

  @override
  Widget build(BuildContext context) {
    //提取列名
    //取出第一筆資料，轉成Json
    //並將欄位提取出來，成為一個陣列(裡面放入資料的鍵的字串)
    //由於提取的資料型還不確定，因此使用dynamic
    List<String> columnName =
        (jsonDecode(posts[0].toJsonObjectString()) as Map<String, dynamic>)
            .keys
            .toList();

    //將List<Post>中，每筆post資料的「欄位名」轉換成List<DataColumn>，一個一個的表格欄位
    List<DataColumn> dataColumns = columnName.map((key) {
      return DataColumn(
        label: Text(key),
      );
    }).toList();

    //進一步將List<Post>轉成List<DataRow>
    //DataRow的內容是由DataCell組成，故需依照Post資料生成DataCell，再傳回DataTable
    //讀出posts內的post
    //將post的變數與內容轉成DataCell
    List<DataRow> dataRow = posts.map((post) {
      Map<String, dynamic> postJson =
          jsonDecode(post.toJsonObjectString()) as Map<String, dynamic>;

      //依照想呈現的欄位，將符合各欄位的post提取出來，轉換成DataCell，並組織成一個list
      List<DataCell> dataCell = columnName.map((key) {
        return DataCell(Text(postJson[key].toString()));
      }).toList();
      return DataRow(cells: dataCell);
    }).toList();

    //DataTable，分別放入兩種欄位規格的函數
    return DataTable(columns: dataColumns, rows: dataRow);
  }
}
