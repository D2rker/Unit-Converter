import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _inputController = TextEditingController();
  String _output = "";
  String _inputUnit = 'cm';
  String _outputUnit = 'm';
  String _errorMessage = "";

  final Map<String, double> unitConversionRates = {
    'cm_m': 0.01,
    'm_cm': 100,
    'g_kg': 0.001,
    'kg_g': 1000,
  };

  void _convert() {
    setState(() {
      _errorMessage = "";
      _output = ""; // Clear previous output on new conversion attempt
      try {
        double input = double.parse(_inputController.text);
        String conversionKey = '${_inputUnit}_$_outputUnit';
        double conversionRate = unitConversionRates[conversionKey] ?? 1.0;
        _output = (input * conversionRate).toStringAsFixed(2); // display 2 decimal places
      } catch (e) {
        _errorMessage = "Please enter a valid number.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Input Value',
                hintText: 'Enter a value',
                errorText: _errorMessage.isEmpty ? null : _errorMessage,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Increased padding
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 18), // Increased font size
            ),
            SizedBox(height: 40), // Increased gap
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _inputUnit,
                    items: [
                      DropdownMenuItem(
                        value: 'cm',
                        child: Row(
                          children: [
                            Icon(Icons.straighten, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text('cm'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'm',
                        child: Row(
                          children: [
                            Icon(Icons.square_foot, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text('m'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'g',
                        child: Row(
                          children: [
                            Icon(Icons.fitness_center, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text('g'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'kg',
                        child: Row(
                          children: [
                            Icon(Icons.line_weight, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text('kg'),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _inputUnit = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Input Unit',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15), // Adjust padding as needed
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _outputUnit,
                    items: [
                      DropdownMenuItem(
                        value: 'cm',
                        child: Row(
                          children: [
                            Icon(Icons.straighten, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text('cm'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'm',
                        child: Row(
                          children: [
                            Icon(Icons.square_foot, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text('m'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'g',
                        child: Row(
                          children: [
                            Icon(Icons.fitness_center, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text('g'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'kg',
                        child: Row(
                          children: [
                            Icon(Icons.line_weight, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text('kg'),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _outputUnit = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Output Unit',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15), // Adjust padding as needed
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40), // Increased gap
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
            ),
            SizedBox(height: 60), // Increased gap
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    _output.isEmpty ? ' ' : 'Output: $_output',
                    key: ValueKey<String>(_output),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
