import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:material_tag_editor/tag_editor_layout_delegate.dart';
import 'package:material_tag_editor/tag_layout.dart';
import 'package:material_tag_editor/tag_render_layout_box.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List values = [];
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFB8C00),
          centerTitle: true,
          title: const Text('Enter a tag...'),
        ),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: Text("others")),
              Container(
                child: !flag
                    ? Center(child: Text("click button to know more"))
                    : TagEditor( 
                        length: values.length,
                        delimiters: [','],
                        hasAddButton: true,
                        inputDecoration: InputDecoration(
                          hintText: "Type Here...",
                          focusedBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(width: 3, color: Color(0xffFB8C00)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(width: 3, color: Color(0xffFB8C00)),
                          ),
                        ),
                        onTagChanged: (newValue) {
                          setState(() {
                            values.add(newValue);
                          });
                        },
                        tagBuilder: (context, index) => _Chip(
                          index: index,
                          label: values[index],
                          onDeleted: onDelete,
                        ),
                      ),
              )
            ],
          ),
        ));
  }

  void onDelete(int value) {}
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Color(0xffFB8C00),
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      labelStyle: TextStyle(color: Colors.white),
      deleteIcon: Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
// FB8C00
