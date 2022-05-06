import 'dart:math';
import 'package:deneme1/themes/config.dart';
import 'package:deneme1/top_100_verbs.dart';
import 'package:deneme1/word_database.dart';
import 'package:flutter/material.dart';

class DropsSnake extends StatefulWidget {
  const DropsSnake({Key? key}) : super(key: key);

  @override
  State<DropsSnake> createState() => _DropsSnakeState();
}

class _DropsSnakeState extends State<DropsSnake> {
  bool inOrder = false;
  List<Word> currentList = TopVerbs.top100VerbsasWord;
  int wordIndex = 0;
  Word currentWord = Word(id: 1, name: '', meaning: '', notes: '');
  String _selectedList = 'Top 100 Verbs';
  List<Word> words = [];
  final List<Word> _top100Verbs = TopVerbs.top100VerbsasWord;
  int row = 5;
  int column = 5;
  double appBarHeight = AppBar().preferredSize.height;
  static const List<String> _menuItems = ['My Words', 'Top 100 Verbs'];
  DraggableScrollableController scrollableController =
      DraggableScrollableController();
  String webResponse = 'NÖ';
  String proN = '';
  List randomizedLetters = List.generate(25, (index) => ' '); //uzunluk 25
  List selectedLetters = List.generate(25, (index) => false);
  int currentIndex = 0;
  int nextIndex = 0;
  late int startIndex;
  final String _germanLetters = 'abcdefghijklmnopqrstuvwxyzäöüß';
  

  @override
  void initState() {
    WordDatabase.instance.queryAllWords().then((List<Word> value) {
      setState(() {
        words = value;
        //currentWord = words.first;
      });
    });
    selectList();
    currentIndex = Random().nextInt(row * column - 1); //24
    startIndex = currentIndex;
    randomizedLetters[currentIndex] = currentWord.name[0];
    selectedLetters[currentIndex] = true;
    randomizeLetters();
    super.initState();
  }


    void randomizeLetters() {
    List<int> available;
    int move;

    for (var j = 1; j < currentWord.name.length; j++) {
      if (currentIndex < row) {
        if ((currentIndex + 1) % column == 0) {
          available = [-1, row]; //top right
        } else if (currentIndex % column == 0) {
          available = [1, row]; //top left
        } else {
          available = [-1, 1, row]; //only top
        }
      } else if (currentIndex >= row * column - 1) {
        if ((currentIndex + 1) % column == 0) {
          available = [-1, -row]; //bottom right
        } else if (currentIndex % column == 0) {
          available = [1, -row]; //bottom left
        } else {
          available = [-1, 1, -row]; //only bottom
        }
      } else if ((currentIndex + 1) % column == 0) {
        available = [-1, -row, row]; //only right
      } else if (currentIndex % column == 0) {
        available = [1, -row, row]; //only left
      } else {
        available = [-1, 1, -row, row]; //not edge
      }

      for(int l=0;l< available.length-1;l++){ //kutular boş mu diye kontrol ediyor
        if (randomizedLetters[currentIndex+available[l]] != " "){
          available.removeAt(l);
        }
      }

      if(available.isNotEmpty){ 
        move = available[available.length==1?0:Random().nextInt(available.length - 1)];
        nextIndex = currentIndex + move;
        randomizedLetters[nextIndex] = currentWord.name[j];
        currentIndex = nextIndex;
      }else { //if there is no available next move, fill the current box and fall back
        randomizedLetters[currentIndex] =  _germanLetters[Random().nextInt(_germanLetters.length - 1)];
        j--; //ya da -2 
      }
      

      
    }
    for (var k = 0; k < randomizedLetters.length; k++) { //kelimeden sonra gridin geri kalanını doldurmak için
      if (randomizedLetters[k] == " ") {
        randomizedLetters[k] =
            _germanLetters[Random().nextInt(_germanLetters.length - 1)];
      }
    }
    setState(() {});
  }

  void setPuzzle() {
    currentIndex = Random().nextInt(row * column - 1); //24
    startIndex = currentIndex;
    randomizedLetters[currentIndex] = currentWord.name[0];
    selectedLetters[currentIndex] = true;
    randomizeLetters();
  }

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
    setPuzzle();
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
    wordIndex = Random().nextInt(currentList.length-1);
    currentWord = currentList[wordIndex];
  }

  void checkWord(int index) {
    int inWord = selectedLetters.where((element) => element == true).length - 1;
    if (randomizedLetters[index] != currentWord.name[inWord]) {
      selectedLetters[index] = false;
      setState(() {});
      showSnackBar("try again", context);
    } else if (inWord == currentWord.name.length - 1) {
      showSnackBar("Correct!", context);
      changeWord('next');
      selectedLetters.fillRange(0, selectedLetters.length - 1, false);
      randomizedLetters = List.generate(25, (index) => ' ');
      setPuzzle();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('KDFT'),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currentWord.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Text(
                        currentWord.meaning,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: GridView.builder(
                    itemCount: row * column,
                    padding: const EdgeInsets.all(12),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: column),
                    itemBuilder: (BuildContext context, int index) {
                      return FloatingActionButton(
                        heroTag:
                            UniqueKey(), //birden fazla olunca karışmasın diye
                        onPressed: () {
                          selectedLetters[index] = true;
                          
                          checkWord(index);
                          setState(() {});
                        },
                        backgroundColor: selectedLetters[index] == true
                            ? Colors.white.withOpacity(0.4)
                            : Colors.grey.withOpacity(0.4),
                        child: Text(randomizedLetters[index]),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
