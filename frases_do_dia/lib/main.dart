import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _phrase = "Clique abaixo para gerar uma frase!";

  List _phrases = [
    "Um pequeno pensamento positivo pela manhã pode mudar todo o seu dia.",
    "Que o dia seja leve, que a tristeza seja breve e que o dia seja feliz. Bom dia!",
    "Que o dia comece bem e termine ainda melhor.",
    "Pra hoje: sorrisos bobos, uma mente tranquila e um coração cheio de paz.",
    "Sempre que o sol nasce, você tem uma nova oportunidade de ser feliz. Bom dia!",
    "Sou apenas um pequeno planeta que se perde diariamente em todo o seu universo.",
    "Novas amizades serão sempre bem-vindas para darem cor e alegria ao meu dia a dia.",
    "Gratidão não é pagamento, mas um reconhecimento que se demonstra no dia a dia.",
    "Nem toda mudança importante acontece de repente e faz barulho, algumas são silenciosas e vão se fazendo no dia a dia.",
  ];

  void generateNewPhrase() {
    _phrase = _phrases[new Random().nextInt(_phrases.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Frase do Dia'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
//            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/logo.png'),
                Text(
                  _phrase,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
                RaisedButton(
                  child: Text(
                    'Nova Frase',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(10),
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      generateNewPhrase();
                    });
                  },
                )
              ],
            ),
          ),
        ));
  }
}
