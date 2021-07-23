import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordo/Models/wordsModel.dart';
showAlertDialog(BuildContext context, {isNew = true,english_text,french_text,index}) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title:(isNew)? Text("New Word") : Text("Update Word"),
    content: (isNew)? MyCustomForm(context: context,) : MyCustomForm(context: context,index: index, update: true,
      data: {
        'english_note':english_text,
        'french_note':french_text,
      },),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final BuildContext context;
  final bool? update;
  final int? index;
  final Map? data;

  const MyCustomForm({Key? key, required this.context, this.index, this.data, this.update=false}) : super(key: key);
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String? eng, fr;
  TextEditingController engController = TextEditingController();
  TextEditingController frController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    if(widget.update!){
      engController.text = widget.data!['english_note'];
      frController.text = widget.data!['french_note'];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return
      Container(
        height: 250,
        child:Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: engController,
                keyboardType: TextInputType.text,
                maxLength: 17,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),

                  hintText: "word in english",
                  filled: true,
                  fillColor: Colors.black12,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }else eng = value;
                  return null;
                },
              ),
              TextFormField(
                controller: frController,
                keyboardType: TextInputType.text,
                maxLength: 17,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "value in frensh",
                  filled: true,
                  fillColor: Colors.black12,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }else{
                    fr = value;
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async{
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                      //WordsModel word = new WordsModel(english_note: eng, french_note: fr,);
                      var words = await WordsModel(english_note: eng, french_note: fr).toMap();
                      //print(words);

                      if(widget.update!){
                        await Hive.box("WORDS").putAt(widget.index!, words);
                        print(Hive.box("WORDS").getAt(widget.index!));
                      }else{
                        await Hive.box("WORDS").add(words);
                      }

                      //print(eng);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFC186),
                  ),
                  child: Text('save'),
                ),
              ),
            ],
          ),
        ) ,
      );
  }
}