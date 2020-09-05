import 'package:flutter/material.dart';
import './constants.dart';

class drawBody extends StatelessWidget{
  int _x;
  int _y;

  drawBody(int x, int y){
    _x = x;
    _y = y;
  }

  @override
  Widget build(BuildContext context) {

    AssetImage _asset = AssetImage('images/body.png');
    Image _image = Image(image: _asset, width: OFFSET.toDouble(), height: OFFSET.toDouble());

    return Container(
      margin: EdgeInsets.only(left:_x.toDouble(),top:_y.toDouble()),
      child: _image,
    );
  }

}