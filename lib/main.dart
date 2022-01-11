import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math';
import "package:http/http.dart" as http;

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

  get randNum => () {
        return Random().nextInt(6) + 1;
      };

  void randDice() {
    leftDiceNumber = randNum();
    rightDiceNumber = randNum();
  }

  final url = 'https://localhost/testpdo/traitement.php';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: UnderlineInputBorder(),
                  labelText: 'Entrez votre nom',
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton(
                    onPressed: () {
                      setState(
                        () {
                          randDice();
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
                          randDice();
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
        ],
      ),
    );
  }
}
