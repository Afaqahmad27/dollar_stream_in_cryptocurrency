import 'dart:async';
import 'dart:convert';

import 'package:dollar_stream/build_coin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data_model.dart';
const apiKey='2b0a7a0d22bccb31230ec999f74bbfe8661f9d44';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<DataModel> _streamController=StreamController();

  @override
  void dispose(){
    _streamController.close();
  }

  @override
  void initState(){
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      getCryptoPrice();
    });

  }

  Future<void> getCryptoPrice() async{
    var url=Uri.parse('https://api.nomics.com/v1/currencies/ticker?key=$apiKey&ids=BNB&convert=USD');
    final response=await http.get(url);
    final dataBody=json.decode(response.body).first;
    DataModel dataModel=DataModel.fromJson(dataBody);
    _streamController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<DataModel>(
          stream: _streamController.stream,
          builder: (context,snapData){
            switch(snapData.connectionState){
              case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
              default: if(snapData.hasError){
                return Text('Please wait...');
              }
              else{
                return BuildCoinWidget(snapData.data!);
              }

            }
          },
        ),
      ),
    );
  }
}

