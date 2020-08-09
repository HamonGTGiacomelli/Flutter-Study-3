import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Trip cost calculator', home: FuelForm());
  }
}

class FuelForm extends StatefulWidget {
  @override
  _FuelFormState createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  TextEditingController tecDistanciaTotal = TextEditingController();
  TextEditingController tecDistanciaUnitaria = TextEditingController();
  TextEditingController tecCustoCombustivel = TextEditingController();

  String texto = "";
  String moeda = "Dollar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip cost calculator"),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
              ),
              child: TextField(
                controller: tecDistanciaTotal,
                decoration: InputDecoration(
                  labelText: 'Distância total',
                  hintText: 'p.ex.124',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
              ),
              child: TextField(
                controller: tecDistanciaUnitaria,
                decoration: InputDecoration(
                  labelText: 'Distância por litro',
                  hintText: 'p.ex. 9.5',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tecCustoCombustivel,
                        decoration: InputDecoration(
                          labelText: 'Preço do combústivel',
                          hintText: 'p.ex. 3.7',
                          labelStyle: Theme.of(context).textTheme.headline6,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      width: 25.0,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: moeda,
                        items: <String>["Dollar", "Euro", "Pounds"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String selectedValue) {
                          setState(() {
                            moeda = selectedValue;
                          });
                        },
                      ),
                    )
                  ],
                )),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Submit',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        texto = calcula();
                      });
                    },
                  ),
                ),
                Container(
                  width: 15.0,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Reset',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      tecCustoCombustivel.text = "";
                      tecDistanciaUnitaria.text = "";
                      tecDistanciaTotal.text = "";
                      setState(() {
                        texto = calcula();
                      });
                    },
                  ),
                ),
              ],
            ),
            Text(texto),
          ],
        ),
      ),
    );
  }

  String calcula() {
    double distancia = double.parse(tecDistanciaTotal.text);
    double disunit = double.parse(tecDistanciaUnitaria.text);
    double custo = double.parse(tecCustoCombustivel.text);

    double total = distancia / disunit * custo;

    String saida = 'O custo total da viagem é de ' +
        total.toStringAsFixed(2) +
        ' ' +
        moeda;

    return saida;
  }
}
