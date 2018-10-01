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

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _information = 'Informe seus dados!';

  void _resetFields() {
    heightController.clear();
    weightController.clear();
    setState(() {
      _information = 'Informe seus dados!';
    });
  }

  void calculate() {
    setState(() {

      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if(imc < 18.6){
        _information = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _information = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _information = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _information = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _information = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _information = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculador de IMC'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, color: Colors.blue, size: 150.0),
              TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.blue, fontSize: 26.0),
                decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(color: Colors.blue)),
                textAlign: TextAlign.center,
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Insira seu peso!';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.blue, fontSize: 26.0),
                decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.blue)),
                textAlign: TextAlign.center,
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Insira sua altura!';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    child: Text('Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 26.0)),
                    color: Colors.blue,
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        calculate();
                      }
                    },
                  ),
                ),
              ),
              Text(_information,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 26.0))
            ],
          ),
        )
      )
    );
  }
}
