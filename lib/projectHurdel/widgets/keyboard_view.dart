import 'package:flutter/material.dart';
import 'package:providerss/projectHurdel/widgets/virtual_key.dart';

const keysList = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M']
];
class KeyboardView extends StatelessWidget {
  const KeyboardView({super.key,required this.excludedLetters,required this.onPressed});
 final List<String> excludedLetters;
 final Function(String) onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.all(4),
      child: Column(
        children: [
          for(var i in keysList)
          Row(
            children: i.map(
              (keywords)=>VirtualKey(
              letter: keywords, 
              exluded: excludedLetters.contains(keywords), 
              onPressed: (value){
                onPressed(value);
              }
              )
            ).toList()
          )
        ],
      ),
      ),
      
    );
  }
}