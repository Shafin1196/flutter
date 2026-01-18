import 'package:flutter/material.dart'; 
import 'package:providerss/projectHurdel/wordle_model.dart';

class WordleView extends StatelessWidget {
   const WordleView({super.key,required this.wordle});
  final Wordle wordle;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: wordle.existInTarget?Colors.white60
        :wordle.doesNotExistInTarget?Colors.blueGrey
        :Colors.transparent,
        border: Border.all(color: Colors.amber),
      ),
      width: 1,
      child: Text(wordle.letter,
      style: TextStyle(
        fontSize: 16,
        color: wordle.existInTarget?Colors.black
        :wordle.doesNotExistInTarget?Colors.white54
        :Colors.white,
      ),
      )
    );
  }
}