import 'package:flutter/material.dart';

class VirtualKey extends StatelessWidget {
  const VirtualKey({super.key,required this.letter,required this.exluded,required this.onPressed});
    final String letter;
  final bool exluded;
  final Function(String) onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(onPressed: (){
        onPressed(letter);
      }, 
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          
        ),
        backgroundColor: exluded? Colors.red:Colors.black,
        foregroundColor: Colors.white,
        padding: EdgeInsets.all(2),
        
      ),
      child:Text(letter,
      style: TextStyle(
      
      ),
      ) 
      ),
    );
  }
}
