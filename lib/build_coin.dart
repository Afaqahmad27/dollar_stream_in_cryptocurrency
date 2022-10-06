import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'data_model.dart';

Widget BuildCoinWidget(DataModel dataModel){
  var usd=double.parse(dataModel.price);
  var pkr=usd*238.895;
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${dataModel.name}',style: TextStyle(fontSize: 18,letterSpacing: 1.2,decoration: TextDecoration.underline),),
        SizedBox(height: 5,),
        SvgPicture.network('${dataModel.image}',width: 150, height: 150,),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('\$ : '),
            Text('${dataModel.price}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PKR : '),
            Text('$pkr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),
      ],
    ),
  );
}
