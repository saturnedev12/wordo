import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:wordo/UI/partials/modals.dart';
class ItemSlidable extends StatefulWidget {
  const ItemSlidable({Key? key, required this.english, required this.french, required this.index}) : super(key: key);
  final String english;
  final String french;
  final int index;
  @override
  _ItemSlidableState createState() => _ItemSlidableState();
}

class _ItemSlidableState extends State<ItemSlidable> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(
          color:(check)? Color(0xFFFAEFE2):Color(0xFFAFD3FD),
          borderRadius: BorderRadius.circular(5)
        ),
        
        child: ListTile(
          leading:Container(
            width: 45,
            height: 32,
            decoration: BoxDecoration(
              //color: Colors.grey,
              image: DecorationImage(image: (check)?AssetImage("assets/english.png"):AssetImage("assets/france.png")),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((check)? widget.english : widget.french,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),
              ),
              IconButton(onPressed: (){
                setState(() {
                  if(check)
                  check = false;
                  else check = true;
                });
              }, icon: (check)? Icon(Icons.remove_red_eye_rounded): Icon(Icons.visibility_off_rounded)),
            ],
          ),
          //subtitle: Text('SlidableDrawerDelegate'),
        ),
      ),
      /*actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => print('Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => print('Share'),
        ),
      ],*/
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'update',
          color: Colors.black45,
          icon: Icons.edit,
          onTap: () => showAlertDialog(context,index: widget.index,isNew: false,english_text: widget.english,french_text: widget.french),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async => await Hive.box("WORDS").deleteAt(widget.index),
        ),
      ],
    );;
  }
}
