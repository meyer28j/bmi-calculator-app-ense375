import 'package:flutter/material.dart';

    const List<String> ftValues = <String>['Feet', '3', '4', '5', '6', '7'];
    const List<String> inValues = <String>['Inches', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'];

class BMI extends StatefulWidget {
    @override
    _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
    final TextEditingController _weightController = TextEditingController();

    double _result = 0;
    String _status = '';

    String ftDropdown = ftValues.first;
    String inDropdown = inValues.first;
    String ftValue = '';
    String inValue = '';

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('BMI Calculator'),
                centerTitle: true,
                ),

            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: DropdownButton<String>(
                                            value: ftDropdown,
                                            icon: const Icon(Icons.arrow_downward),
                                            isExpanded: true,
                                            elevation: 16,
                                            style: const TextStyle(color: Colors.blue,),
                                            underline: Container(
                                                height: 1,
                                                color: Colors.blue,
                                            ),
                                            onChanged: (String? value) {
                                                setState(() {
                                                    ftDropdown = value!;
                                                    ftValue = value!;
                                                });
                                            },
                                            items: ftValues.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                );
                                            }).toList(),
                                        ),
                                    ),
                                ),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: DropdownButton<String>(
                                            value: inDropdown,
                                            icon: const Icon(Icons.arrow_downward),
                                            isExpanded: true,
                                            elevation: 16,
                                            style: const TextStyle(color: Colors.blue,),
                                            underline: Container(
                                                height: 1,
                                                color: Colors.blue,
                                            ),
                                            onChanged: (String? value) {
                                                setState(() {
                                                    inDropdown = value!;
                                                    inValue = value!;
                                                });
                                            },
                                            items: inValues.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                );
                                            }).toList(),
                                        ),
                                    ),
                                ),
                            ],
                        ),
                        SizedBox(height: 50),
                        Padding(
                            padding: EdgeInsets.all(16.0),
                            child: TextField(
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Weight in lbs",
                                ),
                            ),
                        ),
                        SizedBox(height: 50),
                        OutlinedButton(
                            child: Text(
                                'Calculate',
                            ),
                            onPressed: calculateBMI,
                        ),
                        SizedBox(height: 50),
                        Text(
                            'Result:',
                        ),
                        Text(
                            _result == 0 ? '' : '${_result.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 19.4,
                                fontWeight: FontWeight.w500,
                            ),
                        ),
                        Text(
                            _status == '' ? '' : '${_status.toString()}',
                            style: TextStyle(
                                color: Colors.green[400],
                                fontSize: 19.4,
                                fontWeight: FontWeight.w500,
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    void calculateBMI() {
        double heightFt = 0;
        double heightIn = 0;
        double weightLb = 0; 
        try {
            heightFt = double.parse(ftValue);
        } on Exception catch (_) {
            _result = 0;
            _status = "Enter Feet Value";
            setState(() {});
            return;
        }
        try {
            heightIn = double.parse(inValue);
        } on Exception catch (_) {
            _result = 0;
            _status = "Enter Inches Value";
            setState(() {});
            return;
        }
        try {
            weightLb = double.parse(_weightController.text);
        } on Exception catch (_) {
            _result = 0;
            _status = "Enter Weight Value";
            setState(() {});
            return;
        }

        // convert height from ft+in to meters
        double heightM = (heightFt * 12 + heightIn) * 2.54 / 100;
        if (heightM <= 0 || weightLb <= 0) { // avoid divide-by-zero and negative values
            _result = 0;
            _status = 'Invalid Input';
        } else {
            double heightMSquared = heightM * heightM;
            double weightKg = weightLb / 2.2;
            _result = weightKg / heightMSquared;

            if (_result == 0) {
                _status = 'Enter Height and Weight';
            } else if (_result < 18.5) {
                _status = 'Underweight';
            } else if (_result >=18.5 && _result < 25) {
                _status = 'Healthy Weight Range';
            } else if (_result >= 25 && _result < 30) {
                _status = 'Overweight';
            } else if (_result > 30) {
                _status = 'Severely Overweight';
            }
        }
        setState(() {});
    }
}