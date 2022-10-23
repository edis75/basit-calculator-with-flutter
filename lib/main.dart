import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(Calculetor());
}

class Calculetor extends StatelessWidget {
  const Calculetor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculetor',
      home: SimpleCalculetor(),
    );
  }
}

class SimpleCalculetor extends StatefulWidget {
  const SimpleCalculetor({Key? key}) : super(key: key);

  @override
  State<SimpleCalculetor> createState() => _SimpleCalculetorState();
}

class _SimpleCalculetorState extends State<SimpleCalculetor> {
  String equaltion="0";
  String result="0";
  String expresation="";
  double equaltionFontSize=38.0;
  double resultFontSize=48.0;


  buttonPresed (String buttonText){
      setState(() {
        if(buttonText=="C"){
          equaltion="0";
          result="0";
           equaltionFontSize=38.0;
           resultFontSize=48.0;

        }else  if(buttonText=="⌫"){
           equaltionFontSize=48.0;
           resultFontSize=38.0;
          equaltion=equaltion.substring(0,equaltion.length-1);
          if(equaltion=="0"){
            equaltion="0";
          }

        }else if(buttonText=="="){
          equaltionFontSize=38.0;
          resultFontSize=48.0;
          expresation=equaltion;
          expresation = expresation.replaceAll('×', '*');
          expresation = expresation.replaceAll('÷', '/');
          try{
            Parser p = Parser();
            Expression exp = p.parse(expresation);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          }catch (e){
            result =  "error";
          }
        }else {
          equaltionFontSize=48.0;
          resultFontSize=38.0;
          if(equaltion=="0"){
            equaltion=buttonText;
          }
          else{
            equaltion=equaltion+buttonText;
          }
        }
      });
  }
  Widget buildButton(String buttonText,double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid)),
        padding: EdgeInsets.all(16.0),

        onPressed: ()=>buttonPresed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,

          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equaltion,
              style: TextStyle(fontSize: equaltionFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C",1,Colors.redAccent),
                      buildButton("⌫",1,Colors.redAccent),
                      buildButton("÷",1,Colors.redAccent),
                    ]),
                    TableRow(children: [
                      buildButton("7",1,Colors.black54),
                      buildButton("8",1,Colors.black54),
                      buildButton("9",1,Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("4",1,Colors.black54),
                      buildButton("5",1,Colors.black54),
                      buildButton("6",1,Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("1",1,Colors.black54),
                      buildButton("2",1,Colors.black54),
                      buildButton("3",1,Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton(".",1,Colors.black54),
                      buildButton("0",1,Colors.black54),
                      buildButton("00",1,Colors.black54),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.blue),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.redAccent),
                        ]
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
