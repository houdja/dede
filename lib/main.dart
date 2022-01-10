import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dédé'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePage createState() => _DicePage();
}

class _DicePage extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 2;
  var randNum = () {
    return Random().nextInt(6) + 1;
  };
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  setState(
                    () {
                      leftDiceNumber = randNum();
                    },
                  );
                },
                child: Image.asset(
                  'images/dice$leftDiceNumber.png',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  setState(
                    () {
                      rightDiceNumber = randNum();
                    },
                  );
                },
                child: Image.asset(
                  'images/dice$rightDiceNumber.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
