import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordo/UI/partials/slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:wordo/UI/partials/modals.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDCB91),
        title: Text("WORDO",
        style: GoogleFonts.chilanka(
            textStyle: TextStyle(color: Color(0xFFF6F3F7), letterSpacing: .5,fontWeight: FontWeight.w900,fontSize: 25),
      ),),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFCEE4EE),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: Hive.box('WORDS').listenable(),
          builder: (context, Box box, child) {
            List items = box.values.toList();
            return Column(
              children: [
                for(var item in List.from(items.reversed))
                  Padding(padding: EdgeInsets.all(5),
                  child: ItemSlidable(
                    english: item['english_note'],
                    french: item['french_note'],
                    index: items.indexOf(item),

                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFD392),
        child: Icon(
          Icons.add,

        ),
        onPressed: (){
          showAlertDialog(context);
        },
      ),
    );
  }
}
