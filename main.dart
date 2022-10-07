import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _infoText = "coloque suas informações";
  String valorSelecionado = "";



  void _resetFields(){
    _formKey = GlobalKey<FormState>();
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "coloque suas informações";
    });
  }
  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);

      double imc = weight;

      if(imc < 18 && imc >= 2 ){
        _infoText = "Você pode ingerir cerca de 100mg de cafeína por dia ";
      }
      if(imc >= 18 && valorSelecionado == 'gestante'){
        _infoText = "Você pode ingerir cerca de 200mg de cafeína por dia ";
      }else if(imc >= 18 && valorSelecionado == 'sensivel'){
        _infoText = "Você pode ingerir de 100 a 200mg de cafeína por dia ";
      }else if(imc >= 18 && valorSelecionado == ''){
        _infoText = "Você pode ingerir cerca de 400mg de cafeína por dia ";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Cafeína"),
        centerTitle: true,
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.coffee, size: 120.0, color: Colors.brown,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Idade(anos)",
                    labelStyle: TextStyle(color:
                    Colors.brown)

                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.brown, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty){
                    return "Insira sua idade";
                  }else if(double.parse(value) > 150) {
                    return "Informe uma idade menor que 150 anos";
                  }else if(double.parse(value) < 0){
                    return "Informe um número positivo!";
                  }
                },
              ),
               DropdownButton(
                   onChanged: (value){
                     //do your operation while chaning value
                     valorSelecionado = value.toString();
                   },
                items: [
                  DropdownMenuItem(child: Text("Gestante ou Lactante"), value: 'gestante',),
                  DropdownMenuItem(child: Text("Sensivel a cafeina"), value: 'sensivel', ),

                ],
                 iconEnabledColor: Colors.brown,
                 isExpanded: true,

              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate() )
                        _calculate();
                    },
                    child: Text("Calcular",style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                    ),
                  ),
                ),
              ),
              Text(
                "$_infoText", style: TextStyle(color: Colors.brown, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
