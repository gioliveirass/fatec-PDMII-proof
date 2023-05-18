import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prova',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Forms()
    );
  }
}

class Forms extends StatefulWidget {
  @override
  FormsState createState() => FormsState();
}

class FormsState extends State<Forms> {
  static Color correctColor = Colors.black; 
  static Color errorColor = Colors.red; 
  String _result = "";

  final List<Question> questions = [
    new Question(
      label: "1) Qual foi o primeiro pokemon de Ash?",
      options: ["Pidioto", "Caterpie", "Pikachu"],
      rightAnswer: "Pikachu",
      color: correctColor,
    ),

    new Question(
      label: "2) Qual foi o primeiro pokemon capturado por Ash na primeira versão?",
      options: ["Caterpie", "Pikachu", "Scorbunny"],
      rightAnswer: "Caterpie",
      color: correctColor,
    ),

    new Question(
      label: "3) Como se chama a evolução do pokemon Scorbunny?",
      options: ["Firebanny", "Rabito", "Raboot"],
      rightAnswer: "Raboot",
      color: correctColor,
    ),

    new Question(
      label: "4) Qual o primeiro pokemon da pokdex?",
      options: ["Bulbasauro", "Charmander", "Pikachu"],
      rightAnswer: "Bulbasauro",
      color: correctColor,
    ),

    new Question(
      label: "5) Qual o pokemon que originou todos os outros?",
      options: ["Mewtwo", "Arceus", "Mew"],
      rightAnswer: "Arceus",
      color: correctColor,
    )
  ];

  void changeResult(String? result) {
    setState(() {
      result != null 
        ? _result = "Responda a questão " + result 
        : _result = "";
    });
  }

  void changeColor(int questionIndex, Color color) {
    setState(() {
      questions[questionIndex].color = color;
    });
  }

  void showResponse() {
    for(var question in questions) {
      if(question.userAnswer == null) {
        changeResult(question.label);
        return;
      }
    }

    changeResult(null);

    for(var index = 0 ; index < questions.length; index++ ) {
      var question = questions[index];

      if(question.userAnswer == question.rightAnswer) {
        changeColor(index, correctColor);
      } else {
        changeColor(index, errorColor);
      }
    }
  }

  List<Widget> _buildRadioButtons() {
    List<Widget> radioButtons = [];

    for (var question in questions) {
      radioButtons.add(
        Text(
          question.label,
          style: TextStyle(fontSize: 16.0, color: question.color)
        )
      );

      for (var option in question.options) {
        radioButtons.add(
          ListTile(
            title: Text(option, style: TextStyle(
              color: question.color
            )),
            leading: Radio(
              value: option,
              groupValue: question.userAnswer,
              onChanged: (newValue) {
                setState(() {
                  question.userAnswer = newValue;
                });
              }
            ),
          )
        );
      }
    }

    return radioButtons;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Prova'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container (
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRadioButtons(),
                ),

                Text(_result, style: TextStyle(
                  color: Colors.red
                )),

                SizedBox(height: 16.0), 

                ElevatedButton(
                  onPressed: () {
                    showResponse();
                  },
                  child: const Text("Mostrar selecionados")
                )
              ]
            )
          )
        )
      );
    }
}

class Question {
  final String label;
  final String rightAnswer;
  final List<String> options;
  Color color;
  Object? userAnswer;

  Question({
    Key? key,
    required this.label, 
    required this.options,
    required this.rightAnswer,
    required this.color,
    userAnswer
  });
}

