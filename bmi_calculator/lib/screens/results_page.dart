import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String bmi;
  final String result;
  final String interpretation;

  ResultsPage({this.bmi, this.result, this.interpretation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Your Result',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ReusableCard(
              color: kActiveCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    result.toUpperCase(),
                    style: TextStyle(
                      color: Color(0xFF24D876),
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  Text(
                    bmi,
                    style: TextStyle(
                      fontSize: 100.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    interpretation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            text: 'RE-CALCULATE',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
