import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    'https://api.hgbrasil.com/finance?format=json-cors&key=be779e91';

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  double _dollar;
  double _euro;

  void _realChanged(String text) {
    if (text.trim().isEmpty) {
      _clearAllFields();
      return;
    }

    double real = double.parse(text);
    dollarController.text = (real / _dollar).toStringAsFixed(2);
    euroController.text = (real / _dollar).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    if (text.trim().isEmpty) {
      _clearAllFields();
      return;
    }

    double dollar = double.parse(text);
    realController.text = (dollar * _dollar).toStringAsFixed(2);
    euroController.text = (dollar * _dollar / _euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.trim().isEmpty) {
      _clearAllFields();
      return;
    }

    double euro = double.parse(text);
    realController.text = (euro * _euro).toStringAsFixed(2);
    dollarController.text = (euro * _euro / _dollar).toStringAsFixed(2);
  }

  void _clearAllFields() {
    realController.text = '';
    dollarController.text = '';
    euroController.text = '';
  }

  @override
  void dispose() {
    realController.dispose();
    dollarController.dispose();
    euroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text('\$ Conversor \$'),
          backgroundColor: Colors.amber,
          centerTitle: true),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  'Carregando dados...',
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao carregar dados :(',
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                _dollar = snapshot.data['results']['currencies']['USD']['buy'];
                _euro = snapshot.data['results']['currencies']['EUR']['buy'];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 150, color: Colors.amber),
                      builTextField(
                          'Reais', 'R\$', realController, _realChanged),
                      Divider(),
                      builTextField(
                          'Dólares', 'US\$', dollarController, _dollarChanged),
                      Divider(),
                      builTextField('Euros', '€', euroController, _euroChanged)
                    ],
                  ),
                );
              }
              break;
          }
        },
      ),
    );
  }
}

Widget builTextField(String label, String prefix, TextEditingController ctrl,
    Function function) {
  return TextField(
    controller: ctrl,
    onChanged: function,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25),
  );
}
