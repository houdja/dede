import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math';
import "package:http/http.dart" as http;

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
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
  TextEditingController username = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int leftDiceNumber = 1;
  int rightDiceNumber = 2;

  sendScore() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://localhost/apitest/public/api/dedes'));
    request.body = json.encode(
        {"pseudo": username.text, "score": leftDiceNumber + rightDiceNumber});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  void randDice() {
    leftDiceNumber = Random().nextInt(6) + 1;
    rightDiceNumber = Random().nextInt(6) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      'images/dice$leftDiceNumber.png',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      'images/dice$rightDiceNumber.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir les champs';
                    }
                    return null;
                  },
                  controller: username,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    border: UnderlineInputBorder(),
                    labelText: 'Entrez votre nom',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      randDice();
                      sendScore();
                      username.text = '';
                    }
                  });
                },
                child: Text(
                  'Lancer les dés'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
