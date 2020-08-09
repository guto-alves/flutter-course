import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender _selectedGender = Gender.male;
  int _height = 180;
  int _weight = 60;
  int _age = 20;

  void _onGenderSelected(Gender selectedGender) {
    setState(() => _selectedGender = selectedGender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: _selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    child: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                    onTap: () => _onGenderSelected(Gender.male),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: _selectedGender == Gender.female
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    child: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                    onTap: () => _onGenderSelected(Gender.female),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ReusableCard(
            color: kActiveCardColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'HEIGHT',
                  style: kLabelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      _height.toInt().toString(),
                      style: kNumberTextStyle,
                    ),
                    Text(
                      'cm',
                      style: kLabelTextStyle,
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Color(0xFF8D8E98),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    thumbColor: Color(0xFFEB1555),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                    overlayColor: Color(0x29EB1555),
                  ),
                  child: Slider(
                    value: _height.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        _height = newValue.round();
                      });
                    },
                    min: 120.0,
                    max: 220.0,
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ReusableCard(
                  color: kActiveCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'WEIGHT',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        _weight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                _weight--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                _weight++;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: ReusableCard(
                  color: kActiveCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'AGE',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        _age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                _age--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                _age++;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          BottomButton(
            text: 'CALCULATE',
            onTap: () {
              CalculatorBrain calc = CalculatorBrain(_height, _weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    result: calc.getResult(),
                    bmi: calc.getBmi(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
