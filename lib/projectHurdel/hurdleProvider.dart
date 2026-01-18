import 'dart:math' hide log;
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:providerss/projectHurdel/wordle_model.dart';
import "package:english_words/english_words.dart" as word;

class Hurdleprovidere extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];
  String targetWord = '';
  int count = 0;
  final lettersPerRow = 5;
  int index = 0;
  bool wins=false;
  final totalAttepts=6;
  int attepts=0;
  void init() {
    totalWords = word.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandomWord();
  }

  void generateBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ""));
    log("${hurdleBoard.length}");
  }

  void generateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length - 1)]
        .toUpperCase();
    log(targetWord);
  }

  void inputLetter(String letter) {
    if (count < lettersPerRow) {
      rowInputs.add(letter);
      count++;
      hurdleBoard[index] = Wordle(letter: letter);
      index++;
      notifyListeners();
    }
  }
  bool get isAvalidWord =>totalWords.contains(rowInputs.join('').toLowerCase());
  bool get shouldCheckForAnswer=> rowInputs.length==5;
  bool get isTargetWord=> targetWord==rowInputs.join('').toUpperCase();
  bool get noAtteptsLeft => attepts==totalAttepts;

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeLast();
      print(rowInputs);
    }
    if (count > 0) {
      hurdleBoard[index - 1] = Wordle(letter: '');
      count--;
      index--;
    }
    notifyListeners();
  }
  void checkAnswer(){
    final input =rowInputs.join("");
    if(targetWord==input){
      wins=true;
    }else{
      _markLetterOnBoard();
      if(attepts<totalAttepts){
        _goToNextRow();
      }
    }
  }
  
  void _markLetterOnBoard() {
    for(var i in hurdleBoard){
      if(i.letter.isNotEmpty&& targetWord.contains(i.letter)){
        i.existInTarget=true;
      }
      else if(i.letter.isNotEmpty&& !targetWord.contains(i.letter)){
        i.doesNotExistInTarget=true;
        excludedLetters.add(i.letter);
      }
    }
    notifyListeners();
  }
  
  void _goToNextRow() {
    attepts++;
    count=0;
    rowInputs.clear();
  }

  void reset() {
    count=0;
    index=0;
    rowInputs.clear();
    hurdleBoard.clear();
    excludedLetters.clear();
    attepts=0;
    wins=false;
    targetWord='';
    generateBoard();
    generateRandomWord();
    notifyListeners();
  }

}
