import './constants.dart';
import 'package:flutter/material.dart';

class drawHead extends StatelessWidget {
  int _x;
  int _y;
  DIR _dir;

  drawHead(int x, int y, DIR d) {
    if (x < 0) {
      _x = 0;
    } else {
      _x = x;
    }
    if (y < 0) {
      _y = 0;
    } else {
      _y = y;
    }
    _dir = d;
  }

  @override
  Widget build(BuildContext context) {
    AssetImage _asset;

    switch (_dir) {
      case DIR.UP:
        _asset = AssetImage('images/headup.png');
        break;
      case DIR.DOWN:
        _asset = AssetImage('images/headdown.png');
        break;
      case DIR.LEFT:
        _asset = AssetImage('images/headleft.png');
        break;
      case DIR.RIGHT:
        _asset = AssetImage('images/headright.png');
        break;
      default:
        break;
    }

    Image _image = Image(
        image: _asset, width: OFFSET.toDouble(), height: OFFSET.toDouble());

    return Container(
      margin: EdgeInsets.only(left: _x.toDouble(), top: _y.toDouble()),
      child: _image,
    );
  }
}
