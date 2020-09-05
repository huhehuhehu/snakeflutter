import 'dart:async';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import './drawFood.dart';
import './drawBody.dart';
import './drawHead.dart';
import './constants.dart';
import './highscores.dart';

double _screenX;
double _screenY;
bool EXITNOW = false;
SharedPreferences storage;

class SnakeEngine extends StatelessWidget {

  SnakeEngine(SharedPreferences s){
    storage = s;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: thegame(context),
    );
  }
}

class thegame extends StatefulWidget {
  BuildContext _context;

  thegame(BuildContext context) {
    //EXITNOW = false;
    _context = context;
    _screenX = MediaQuery.of(context).size.width.floorToDouble() - 50;
    _screenY = MediaQuery.of(context).size.height.floorToDouble() - 50;
  }

  @override
  State<StatefulWidget> createState() => _boardState(_context);
}

class _boardState extends State<thegame> {
  static const _MARGIN = 25.0;

  int _length;
  int _foodX;
  int _foodY;

  int _score;


  DIR _dir = DIR.RIGHT;
  bool _lockDIR = false;

  List<int> _snakeX;
  List<int> _snakeY;

  int _maxX;
  int _maxY;

  Random rand;

  _boardState(BuildContext context) {
    rand = new Random();
    _length = 3;
    _score = 0;

    _maxX = _screenX ~/ OFFSET - 1;
    _maxY = _screenY ~/ OFFSET - 1;

    _snakeX = new List(_maxX * _maxY);
    _snakeY = new List(_maxX * _maxY);

    for (int i = 0; i < _length; i++) {
      _snakeX[i] = (5 - i) * OFFSET;
      _snakeY[i] = 3 * OFFSET;
    }

    _spawnFood();

    Timer.periodic(PING, (Timer timer) {
      _updateBoard();
      if (_isDead() || EXITNOW) {
        timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        EXITNOW = true;
        return false;
    },
      child: new Scaffold(
        body: Container(
          margin: const EdgeInsets.all(_MARGIN),
          width: ((_maxX + 1) * OFFSET).toDouble(),
          height: ((_maxY + 1) * OFFSET).toDouble(),
          color: Colors.yellowAccent,
          child: Stack(
            children: [
              drawFood(_foodX, _foodY),
              for (int i = 1; i < _length; i++) drawBody(_snakeX[i], _snakeY[i]),
              drawHead(_snakeX[HEAD], _snakeY[HEAD], _dir),
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (!_lockDIR && _dir != DIR.UP && details.delta.dy > 0) {
                    _dir = DIR.DOWN;
                    _lockDIR = true;
                  } else if (!_lockDIR &&
                      _dir != DIR.DOWN &&
                      details.delta.dy < 0) {
                    _dir = DIR.UP;
                    _lockDIR = true;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (!_lockDIR && _dir != DIR.LEFT && details.delta.dx > 0) {
                    _dir = DIR.RIGHT;
                    _lockDIR = true;
                  } else if (!_lockDIR &&
                      _dir != DIR.RIGHT &&
                      details.delta.dx < 0) {
                    _dir = DIR.LEFT;
                    _lockDIR = true;
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateBoard() {
    setState(() {
      for (int i = _length; i > 0; i--) {
        _snakeX[i] = _snakeX[i - 1];
        _snakeY[i] = _snakeY[i - 1];
      }

      switch (_dir) {
        case DIR.UP:
          _snakeY[HEAD] = _snakeY[HEAD] - OFFSET;
          break;
        case DIR.DOWN:
          _snakeY[HEAD] = _snakeY[HEAD] + OFFSET;
          break;
        case DIR.LEFT:
          _snakeX[HEAD] = _snakeX[HEAD] - OFFSET;
          break;
        case DIR.RIGHT:
          _snakeX[HEAD] = _snakeX[HEAD] + OFFSET;
          break;
      }

      if (_isEaten()) {
        _eat();
      }

      _lockDIR = false;
    });
  }

  bool isLegit() {
    for (int i = 1; i < _length; i++) {
      if (_foodX == _snakeX[i] && _foodY == _snakeY[i]) return false;
    }
    return true;
  }

  bool _isDead() {
    if (_snakeX[HEAD] < 0)
      return true;
    else if (_snakeY[HEAD] < 0)
      return true;
    else if (_snakeY[HEAD] > _screenY - OFFSET)
      return true;
    else if (_snakeX[HEAD] > _screenX - OFFSET) return true;

    if (_length > 4) {
      for (int i = 4; i < _length; i++) {
        if (_snakeX[HEAD] == _snakeX[i] && _snakeY[HEAD] == _snakeY[i])
          return true;
      }
    }

    return false;
  }

  bool _isEaten() {
    if (_snakeX[HEAD] == _foodX && _snakeY[HEAD] == _foodY) return true;
    return false;
  }

  void _eat() {
    _length++;
    _score++;
    _spawnFood();
  }

  void _spawnFood() {
    do {
      _foodX = rand.nextInt(_maxX) * OFFSET;
      _foodY = rand.nextInt(_maxY) * OFFSET;
    } while (!isLegit());
  }

  _storeScore() async{
    
  }

}
