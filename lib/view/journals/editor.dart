import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html_editor_enhanced/utils/options.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

class TextEditor extends StatelessWidget {
  const TextEditor({
    Key? key,
    required this.controller,
    required this.size, required this.hintText,
  }) : super(key: key);

  final HtmlEditorController controller;
  final Size size;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: controller, //required
      htmlToolbarOptions: HtmlToolbarOptions(
        toolbarPosition: ToolbarPosition.belowEditor,
        toolbarType: ToolbarType.nativeExpandable,
      ),
      htmlEditorOptions: HtmlEditorOptions(

        hint: "$hintText",
        //initalText: "text content initial, if any",
      ),
      otherOptions: OtherOptions(
        decoration: BoxDecoration(
            border: Border.all(width: 0, color: Colors.transparent)
        ),
        height: size.height-250,
      ),
    );
  }
}
