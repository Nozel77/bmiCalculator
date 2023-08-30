import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController _beratBadan = TextEditingController();
  TextEditingController _tinggiBadan = TextEditingController();

  String _bmiResult = "";
  String _bmiInterpretation = "";

  Widget form(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.black,
            )),
      ),
    );
  }

  double calculateBMI(double beratBadan, double tinggiBadan) {
    double bmi = beratBadan / (tinggiBadan * tinggiBadan);
    return bmi;
  }

  String ketentuanBMI(double bmi) {
    if (bmi < 18.5) {
      return "Berat badan kurang";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Berat badan normal";
    } else if (bmi >= 25 && bmi < 30) {
      return "Berat badan berlebih";
    } else if (bmi >= 30 && bmi < 35) {
      return "Obesitas tingkat 1";
    } else if (bmi >= 35 && bmi < 40) {
      return "Obesitas tingkat 2";
    } else {
      return "Obesitas tingkat 3";
    }
  }

  void _resetFields() {
    setState(() {
      _beratBadan.clear();
      _tinggiBadan.clear();
      _bmiResult = "BMI :";
      _bmiInterpretation = "Keterangan BMI : ";
    });
  }

  void _calculateButtonPressed() {
    double berat = double.tryParse(_beratBadan.text) ?? 0.0;
    double tinggi = double.tryParse(_tinggiBadan.text) ?? 0.0;
    double bmi = calculateBMI(berat, tinggi);
    String bmiInterpretation = ketentuanBMI(bmi);

    setState(() {
      _bmiResult = "BMI: ${bmi.toStringAsFixed(2)}";
      _bmiInterpretation = "Keterangan BMI: $bmiInterpretation";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            form("Masukkan Berat Badan (KG)", _beratBadan),
            form("Masukkan Tinggi Badan (M)", _tinggiBadan),
            ElevatedButton(
              onPressed: _calculateButtonPressed,
              child: Text("Hitung"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _resetFields,
              child: Text("Reset"),
            ),
            SizedBox(height: 20,),
            Text(
              _bmiResult,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              _bmiInterpretation,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}