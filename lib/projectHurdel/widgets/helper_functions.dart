import 'package:flutter/material.dart';
void showMesssage(BuildContext context,String msg){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg))
  );
}
void showResult({
  required String message,
  required String title,
  required BuildContext context,
  required VoidCallback onPlayAgain,
  required VoidCallback onCancel,
}) {
  showDialog(
    context: context, 
    builder: (context)=>AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed:onCancel , 
        child: Text("cancel")),
         TextButton(onPressed: onPlayAgain, 
        child: Text("Play again")),
      ],
    )
    );
}
