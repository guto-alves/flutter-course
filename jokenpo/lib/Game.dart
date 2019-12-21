import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jokenpo/GameChoices.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var _appChoiceImage = AssetImage('images/padrao.png');

  String _gameResultText = "Escolha uma opção abaixo";

  Choice generateAppChoice() {
    List choices = Choice.values;
    Choice appChoice = choices[new Random().nextInt(choices.length)];

    switch (appChoice) {
      case Choice.Stone:
        setState(() {
          _appChoiceImage = AssetImage('images/pedra.png');
        });
        break;
      case Choice.Paper:
        setState(() {
          _appChoiceImage = AssetImage('images/papel.png');
        });
        break;
      case Choice.Scissors:
        setState(() {
          _appChoiceImage = AssetImage('images/tesoura.png');
        });
        break;
    }

    return appChoice;
  }

  void checkWinner(Choice userChoice, Choice appChoice) {
    if ((userChoice == Choice.Stone && appChoice == Choice.Scissors) ||
        (userChoice == Choice.Scissors && appChoice == Choice.Paper) ||
        (userChoice == Choice.Paper && appChoice == Choice.Stone))
      displayResult("Parabéns!! Você ganhou :)");
    else if ((appChoice == Choice.Stone && userChoice == Choice.Scissors) ||
        (appChoice == Choice.Scissors && userChoice == Choice.Paper) ||
        (appChoice == Choice.Paper && userChoice == Choice.Stone))
      displayResult("Você perdeu :(");
    else
      displayResult("Empatamos ;)");
  }

  void displayResult(String result) {
    setState(() {
      _gameResultText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokenpo'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              'Escolha do App',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Image(
            image: _appChoiceImage,
          ),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _gameResultText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => checkWinner(Choice.Stone, generateAppChoice()),
                child: Image.asset(
                  'images/pedra.png',
                  height: 100,
                ),
              ),
              GestureDetector(
                onTap: () => checkWinner(Choice.Paper, generateAppChoice()),
                child: Image.asset(
                  'images/papel.png',
                  height: 100,
                ),
              ),
              GestureDetector(
                onTap: () => checkWinner(Choice.Scissors, generateAppChoice()),
                child: Image.asset(
                  'images/tesoura.png',
                  height: 100,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
