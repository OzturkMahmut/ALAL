import 'dart:math';
import 'package:deneme1/word_database.dart';
import 'package:flutter/material.dart';
import '../top_100_verbs.dart';

class LetterPracticePage extends StatefulWidget {
  const LetterPracticePage({Key? key}) : super(key: key);

  @override
  State<LetterPracticePage> createState() => _LetterPracticePageState();
}

class _LetterPracticePageState extends State<LetterPracticePage> {
  List<Word> words = [];
  bool inOrder = false;
  int wordIndex = 0;
  List<Word> currentList = TopVerbs.top100VerbsasWord;
  Word currentWord = Word(id: 1, name: '', meaning: '', notes: '');
  String _selectedList = 'Top 100 Verbs';
  final List<Word> _top100Verbs = TopVerbs.top100VerbsasWord;
  int letterIndex = 0;
  List<String> suggestionLetters =
      List<String>.generate(5, (index) => " ", growable: false);
  List<Color> suggestionLetterBorderColors =
      List<Color>.generate(5, (index) => Colors.grey, growable: false);
  final String _germanLetters = 'abcdefghijklmnopqrstuvwxyzäöüß';

  void changeWord(String direction) {
    if (!inOrder) {
      wordIndex = Random().nextInt(currentList.length - 1);
    } else {
      switch (direction) {
        case 'next':
          {
            wordIndex += 1;
          }
          break;

        case 'previous':
          {
            wordIndex -= 1;
          }
          break;
      }
    }

    if (wordIndex < 0) {
      wordIndex = 0;
    } else if (wordIndex > currentList.length - 1) {
      wordIndex = currentList.length - 1;
    }

    currentWord = currentList[wordIndex];
  }

  @override
  void initState() {
    WordDatabase.instance.queryAllWords().then((List<Word> value) {
      setState(() {
        words = value;
      });
    });
    selectList();
    shuffleSuggList(letterIndex);
    super.initState();
  }

  void selectList() {
    switch (_selectedList) {
      case 'My Words':
        {
          currentList = words;
        }
        break;

      case 'Top 100 Verbs':
        {
          currentList = _top100Verbs;
        }
        break;
    }
    wordIndex = 0;
    currentWord = currentList[wordIndex];
  }

  void checkLetter(int letterIndex, int suggestionIndex) {
    if (suggestionLetters[suggestionIndex] ==
        currentWord.meaning[letterIndex]) {
      if (letterIndex == currentWord.meaning.length - 1) {
        //experimental-->
        suggestionLetterBorderColors[suggestionIndex] = Colors.green;
        Future.delayed(const Duration(milliseconds: 200));
        suggestionLetterBorderColors[suggestionIndex] = Colors.grey;
        //<--experimental
        changeWord('next');
      } else {
        letterIndex += 1;
        shuffleSuggList(letterIndex);
      }
      suggestionLetterBorderColors =
          List<Color>.generate(5, (index) => Colors.grey, growable: false);
    } else {
      suggestionLetterBorderColors[suggestionIndex] = Colors.red;
    }
  }

  void shuffleSuggList(int letterIndex) {
    for (var i = 0; i < suggestionLetters.length - 1; i++) {
      suggestionLetters[i] =
          _germanLetters[Random().nextInt(_germanLetters.length - 1)];
    }
    suggestionLetters[Random().nextInt(suggestionLetters.length - 1)] =
        currentWord.meaning[letterIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(children: [
          Text(currentWord.name),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  checkLetter(letterIndex, 0);
                  setState(() {});
                },
                child: Text(suggestionLetters[0]),
                style: OutlinedButton.styleFrom(
                  primary: suggestionLetterBorderColors[0],
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  checkLetter(letterIndex, 1);
                  setState(() {});
                },
                child: Text(suggestionLetters[1]),
                style: OutlinedButton.styleFrom(
                  primary: suggestionLetterBorderColors[1],
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  checkLetter(letterIndex, 2);
                  setState(() {});
                },
                child: Text(suggestionLetters[2]),
                style: OutlinedButton.styleFrom(
                  primary: suggestionLetterBorderColors[2],
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  checkLetter(letterIndex, 3);
                  setState(() {});
                },
                child: Text(suggestionLetters[3]),
                style: OutlinedButton.styleFrom(
                  primary: suggestionLetterBorderColors[3],
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  checkLetter(letterIndex, 4);
                  setState(() {});
                },
                child: Text(suggestionLetters[4]),
                style: OutlinedButton.styleFrom(
                  primary: suggestionLetterBorderColors[4],
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
