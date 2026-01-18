import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerss/projectHurdel/hurdleProvider.dart';
import 'package:providerss/projectHurdel/widgets/helper_functions.dart';
import 'package:providerss/projectHurdel/widgets/keyboard_view.dart';
import 'package:providerss/projectHurdel/wordle_view.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {

  @override
  void didChangeDependencies() {
    Provider.of<Hurdleprovidere>(context,listen:false).init();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Hurdle"),
        centerTitle: true,
      ),
      body:SafeArea(
        child: Center(
          child: Column(
            children: [
             Expanded(
               child: SizedBox(
                width: MediaQuery.of(context).size.width*.7,
                 child: Consumer<Hurdleprovidere>(builder: (context,provider,child){
                  return  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      ), 
                    itemCount: provider.hurdleBoard.length,
                    itemBuilder: (context,index){
                      final wordle=provider.hurdleBoard[index];
                      return WordleView(wordle: wordle);
                    }
                    );
                 }),
               ),
             ),
             Consumer<Hurdleprovidere>(builder: (context,provider,child){
              return KeyboardView(
                excludedLetters: provider.excludedLetters,
                onPressed: (value) {
                 provider.inputLetter(value);
                },
              );
             }),
        
             Padding(
              padding: EdgeInsets.all(16),
              child: Consumer<Hurdleprovidere>(builder: (context,provider,child){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      provider.deleteLetter();
                    }, 
                    child: Text("DELETE")),
                    ElevatedButton(onPressed: (){
                      if(!provider.isAvalidWord){
                        showMesssage(context, "Not a word in my dictionary");
                      }
                      if(provider.shouldCheckForAnswer){
                        provider.checkAnswer();
                        if(provider.wins){
                          showResult(
                            message: "The word ${provider.targetWord}", 
                            title: "You Win!", 
                            context: context, 
                            onPlayAgain: (){
                              Navigator.pop(context);
                              provider.reset();
                            }, 
                            onCancel: (){
                              Navigator.pop(context);
                            },
                            );
                        }
                        else if(provider.noAtteptsLeft){
                          showResult(
                            message: " The word was ${provider.targetWord}", 
                            title: "You Lost!", 
                            context: context, 
                            onPlayAgain: (){
                              Navigator.pop(context);
                              provider.reset();
        
                            }, 
                            onCancel: (){
                              Navigator.pop(context);
                            }
                            );
                        }
                      }
                    }, 
                    child: Text("SUBMIT")),
        
                  ],
                );
              }),
             )
            ],
          ),
        ),
      ) ,
      
    );
  }
}