import 'package:flutter/material.dart';

    const List<String> ftValues = <String>['Feet', '3', '4', '5', '6', '7'];
    const List<String> inValues = <String>['Inches', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'];

class BMI extends StatefulWidget {
    @override
    _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
    // final TextEditingController _heightController = TextEditingController();
    final TextEditingController _weightController = TextEditingController();

    double _result = 0;

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
                        // TODO: change into 2 dropdowns: ft and in
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
                                    labelText: "weight in lbs",
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
                            'Result',
                        ),
                        Text(
                            _result == '' ? 'Enter Value' : '${_result.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.redAccent,
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
        // double heightInCm = double.parse(_heightController.text);
        double weightLb = double.parse(_weightController.text);
        double heightFt = double.parse(ftValue);
        double heightIn = double.parse(inValue);

        // double heightInM = heightInCm / 100;

        // double heightSquared = heightInM * heightInM;
        // _result = weightInKg / heightInM;
        _result = weightLb / (heightFt + heightIn);
        setState(() {});
    }
}