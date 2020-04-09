import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _result = 'Informe seus dados';

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _result = 'Informe seus dados';
      _formKey.currentState.reset();
    });
  }

  void _calculateBMI() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);
    double bmi = weight / (height * height);

    setState(() {
      if (bmi < 18.6) {
        _result = 'Abaixo do Peso\nSeu IMC: ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _result = 'Peso Ideal\nSeu IMC: ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _result = 'Levemente Acima\nSeu IMC: ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _result = 'Obesidade Grau I\nSeu IMC: ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _result = 'Obesidade Grau II\nSeu IMC: ${bmi.toStringAsPrecision(4)}';
      } else {
        _result = 'Obesidade Grau III\nSeu IMC: ${bmi.toStringAsPrecision(4)}';
      }
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _resetFields();
                })
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120, color: Colors.green),
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Peso (ex.: 69.2)',
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: weightController,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Insira sua Altura!";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Altura (ex.: 1.70)',
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: heightController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          'Calcular',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculateBMI();
                          }
                        },
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(_result,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25))
                ],
              )),
          padding: EdgeInsets.all(16),
        ));
  }
}
