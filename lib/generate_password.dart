import 'package:flutter/material.dart';
enum SingingCharacter { first, firstAndLast, fristToLast }

class GeneratePassword extends StatefulWidget {
  @override
  _GeneratePasswordState createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {

  SingingCharacter _character = SingingCharacter.first;

  List _listText = [
    "Sport",
    "Sciences",
    "Iraq",
    "Egypt",
    "Door",
    "Car",
    "Lion",
    "Donkey",
    "Phone",
    "Computer",
    "Cat"
  ];
  var _listHistory = [
    "2010",
    "1987",
    "1290",
    "2003",
    "1900",
    "1970",
    "1863",
    "1820",
    "908",
    "201"
  ];
  var _listMath = [
    "5+6",
    "(6*4)-3",
    "2-4(8+5)",
    "6/4=2",
  ];

  bool _isGenerate = true;

  var _result = "";

  List _types = ["first", "first and last", "first to last"];
  String _type ="";
  String _allChar = "";

  TextEditingController _ctrlNum = TextEditingController();
  TextEditingController _ctrlText = TextEditingController();

  @override
  void initState() {
    _ctrlNum.text = "6";
    super.initState();
  }

  @override
  void dispose() {
    _ctrlNum.dispose();
    _ctrlText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: (){
                      setState(() {
                        _isGenerate = true;
                        _result = "";
                      });
                    }, child: Text("Encrypt")),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        _isGenerate = false;
                        _result = "";
                      });
                    }, child: Text("Decoding"))
                  ],
                ),

                Visibility(
                  visible: _isGenerate,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _ctrlNum,
                  ),
                ),

                Column(
                  children: [
                    ListTile(
                      title: Text(_types[0]),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.first,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            _type = _types[0];
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(_types[1]),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.firstAndLast,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            _type = _types[1];
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(_types[2]),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.fristToLast,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            _type = _types[2];
                          });
                        },
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: _isGenerate?
                      () => _encrypt(type: _type, size: int.parse(_ctrlNum.text)):
                      () => _decoding(type: _type, text: _ctrlText.text),
                  child: Text(_isGenerate?"Encrypt":"Decoding")
                ),

                Container(
                  color: Colors.black26,
                  padding: EdgeInsets.all(8.0),
                  child: _isGenerate?SelectableText(_result):
                  TextField(minLines: 2, maxLines: 20, controller: _ctrlText),
                ),

                SizedBox(height: 30),
                Container(
                  color: Colors.black12,
                  padding: EdgeInsets.all(8.0),
                  child: SelectableText(_isGenerate?_allChar:_result),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _encrypt({type = "first", int size = 6}) {
    String result = "";
    String resultAllChar = "";

    _listText.shuffle();
    _listHistory.shuffle();
    _listMath.shuffle();

    if(type == "first") {
      List list = [];
      List listAllChar = [];

      _listText.forEach((element) {
          list.add(element[0]);
          listAllChar.add(element);
      });

      _listHistory.forEach((element) {
          list.add(element[0]);
          listAllChar.add(element);
      });

      _listMath.forEach((element) {
          list.add(element[0]);
          listAllChar.add(element);
      });

      result = list.join("");
      resultAllChar = listAllChar.join(" - ");
    }

    if(type == "first and last") {
      List list = [];
      List listAllChar = [];

      _listText.forEach((element) {
        list.add("${element[0]}${element.substring(element.length - 1)}");
        listAllChar.add("$element");
      });

      _listHistory.forEach((element) {
          list.add("${element[0]}${element.substring(element.length - 1)}");
          listAllChar.add("$element");
      });

      _listMath.forEach((element) {
          list.add("${element[0]}${element.substring(element.length - 1)}");
          listAllChar.add("$element");
      });

      result = list.join("");
      resultAllChar = listAllChar.join(" - ");
    }

    if(type == "first to last") {
      List list = [];
      List listAllChar = [];

      _listText.forEach((element) {
          int res = element.toString().length ~/ 2;
          list.add("${element[res]}");
          listAllChar.add("$element");
      });

      _listHistory.forEach((element) {
        int res = element.toString().length ~/ 2;
        list.add("${element[res]}");
        listAllChar.add("$element");
      });

      _listMath.forEach((element) {
        int res = element.toString().length ~/ 2;
        list.add("${element[res]}");
        listAllChar.add("$element");
      });

      result = list.join("");
      resultAllChar = listAllChar.join(" - ");
    }

    setState(() {
      _result = result;
      _allChar = resultAllChar;
    });
  }

  _decoding({type = "first", String text = ""}) {
    String result = "";

    List list = text.split(" - ");

    if(type == "first") {
      List listAllChar = [];

      list.forEach((element) {
        listAllChar.add(element[0]);
      });

      result = listAllChar.join("");
    }

    if(type == "first and last") {
      List listAllChar = [];

      list.forEach((element) {
        listAllChar.add("${element[0]}${element.substring(element.length - 1)}");
      });

      result = listAllChar.join("");
    }

    if(type == "first to last") {

      List listAllChar = [];

      list.forEach((element) {
        int res = element.toString().length ~/ 2;
        listAllChar.add(element[res]);
      });

      result = listAllChar.join("");
    }

    setState(() {
      _result = result;
    });
  }

}
