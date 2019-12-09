import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projetoflutterv4/models/user_model.dart';
import 'package:projetoflutterv4/screens/home_screen.dart';

class FeedBackScreen extends StatefulWidget {
  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final _user = UserModel().firebaseUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Feedback'),
          centerTitle: true,
        ),
        body: MyStatefulWidget(),
      ),
    );
  }
}

enum SingingCharacter { Bom, Medio, Ruim }

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _firstSession = 0;
  int _secondSession = 0;
  int _thirdSession = 0;

  bool _endFeedBack = false;

  int loadTimer = 0;

  void thirdFeedBack(int i) {
    setState(() {
      _thirdSession = i;
    });
  }

  void finalFeedback() {
    setState(() {
      _endFeedBack = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
            elevation: 1.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Qual a sua satisfação geral com o nosso app?'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('Muito Satisfeito'),
                        Radio(
                          groupValue: _firstSession,
                          onChanged: (int i) =>
                              setState(() => _firstSession = i),
                          value: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Satisfeito'),
                        Radio(
                          groupValue: _firstSession,
                          onChanged: (int i) =>
                              setState(() => _firstSession = i),
                          value: 2,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Insatisfeito'),
                        Radio(
                          groupValue: _firstSession,
                          onChanged: (int i) =>
                              setState(() => _firstSession = i),
                          value: 3,
                        ),
                      ],
                    ),
                  ],
                ),
                Text(_firstSession.toString())
              ],
            )),
        Opacity(
          opacity: _firstSession != 0 ? 1.0 : 0.0,
          child: Card(
              elevation: 1.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Quais peças gostaria de ver mais por aqui?'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Layout'),
                          Radio(
                            groupValue: _secondSession,
                            onChanged: (int i) =>
                                setState(() => _secondSession = i),
                            value: 1,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Funcionalidades'),
                          Radio(
                            groupValue: _secondSession,
                            onChanged: (int i) =>
                                setState(() => _secondSession = i),
                            value: 2,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Facilidade de usar'),
                          Radio(
                            groupValue: _secondSession,
                            onChanged: (int i) =>
                                setState(() => _secondSession = i),
                            value: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(_secondSession.toString())
                ],
              )),
        ),
        Opacity(
          opacity: _secondSession != 0 ? 1.0 : 0.0,
          child: Card(
              elevation: 1.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Qual estilo?'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Prata'),
                          Radio(
                            groupValue: _thirdSession,
                            onChanged: (int i) =>
                                setState(() => _thirdSession = i),
                            value: 1,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Dourado'),
                          Radio(
                            groupValue: _thirdSession,
                            onChanged: (int i) =>
                                setState(() => _thirdSession = i),
                            value: 2,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Prata e Dourado'),
                          Radio(
                            groupValue: _thirdSession,
                            onChanged: (int i) =>
                                setState(() => _thirdSession = i),
                            value: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(_thirdSession.toString())
                ],
              )),
        ),
        Opacity(
          opacity: _thirdSession != 0 ? 1.0 : 0.0,
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                color: Colors.blue,
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                //`Icon` to display
                label: Text(
                  'Enviar Feedback',
                  style: TextStyle(color: Colors.white),
                ),
                //`Text` to display
                onPressed: () {
                  finalFeedback();
//                loadData();
                },
              ),
              Opacity(
                opacity: _endFeedBack ? 1.0 : 0.0,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      'Muito Obrigado pelo seu Feedback ;) \n Aguarde que voce será redirecionado õ/'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
