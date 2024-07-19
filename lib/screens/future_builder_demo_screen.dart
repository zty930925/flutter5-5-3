//引入核心套件
import 'package:flutter/material.dart';
//安裝http套件，讓後續可以從外部抓取資料
import 'package:http/http.dart' as http;

//建立一個類別函數叫做FutureBuilderDemoScreen，並繼承StatelessWidget
class FutureBuilderDemoScreen extends StatelessWidget {
  //與外部系統要求資料，是無法確保回應時間的，因此使用Future包覆著
  //告訴電腦，不要讓主程序等待，而使頁面延遲
  Future<dynamic> getDataFromRemote() async {
    //解析遠端系統網址
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    //透過http的get方法照訪該網址
    var response = await http.get(url);
    //將照訪的結果傳回來
    return response.body;
  }

  @override
  //於此處實踐StatelessWidget的build方法
  Widget build(BuildContext context) {
    //使用FutureBuilder
    //FutureBuilder的功能:與外部系統要資料時，可以先初步渲染畫面
    //資料取回時，再渲染一次畫面
    return FutureBuilder(
        //FutureBuilder有兩個主要參數future、builder
        //future：一個Future，後接「從外部系統取得資料的函數」
        future: getDataFromRemote(),
        //builder；定義當Future完成時應如何構建widget
        builder: (BuildContext context, AsyncSnapshot<dynamic> asyncSnapshot) {
          //構建widget：future完成後，顯示取的的資料
          return Scaffold(
            body: Text(asyncSnapshot.data),
          );
        });
  }
}
