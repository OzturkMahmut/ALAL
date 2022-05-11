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
  List buttonClickable = List.generate(25, (index) => false);
  List<int> appointedWordIndexes = []; 
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
    setPuzzle();
    super.initState();
  }

  void setPuzzle() {
    List<int> availableForClick;
    currentIndex = Random().nextInt(row * column); //24
    startIndex = currentIndex;
    appointedWordIndexes.add(startIndex);
    randomizedLetters[currentIndex] = currentWord.name[0];
    buttonClickable.fillRange(0, buttonClickable.length, false);
    availableForClick = getNeigbourCells(currentIndex);
    for (int l = 0; l < availableForClick.length; l++) {
      buttonClickable[currentIndex + availableForClick[l]] = true;
    }
    selectedLetters[currentIndex] = true;
    randomizeLetters();
  }

    void randomizeLetters() {
    List<int> available;
    int move;

    for (var j = 1; j < currentWord.name.length; j++) {
      available = getNeigbourCells(currentIndex);
      print("1: $appointedWordIndexes");
      for (int l = 0; l < available.length; l++) {
        if ( randomizedLetters[currentIndex + available[l]] != " "|| appointedWordIndexes.contains(currentIndex + available[l])) {
          //print("in");
          available.removeAt(l);
          l--;
        }
      }
      //print("av:$available");
      if (available.isNotEmpty) {
        move = available[
            available.length == 1 ? 0 : Random().nextInt(available.length)];
        //print("move: $move");
        nextIndex = currentIndex + move;
        randomizedLetters[nextIndex] = currentWord.name[j];
        appointedWordIndexes.add(nextIndex);
        currentIndex = nextIndex;
      } else {
        print("maybe?");
        //if there is no available next move, fill the current box and fall back
        randomizedLetters[currentIndex] =
            _germanLetters[Random().nextInt(_germanLetters.length)];
        j -= 2; 
        appointedWordIndexes.remove(currentIndex);
        currentIndex = appointedWordIndexes.last;
      }
    }
    print(appointedWordIndexes);
    for (var k = 0; k < randomizedLetters.length; k++) {
      //kelimeden sonra gridin geri kalanını doldurmak için
      if (!appointedWordIndexes.contains(k)) { //k kelimenin indexlerinden değilse
        randomizedLetters[k] =
            _germanLetters[Random().nextInt(_germanLetters.length )];
      }
    }
    setState(() {});
  }

  void changeWord(String direction) {
    if (!inOrder) {
      wordIndex = Random().nextInt(currentList.length);
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
    //setPuzzle();
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
    wordIndex = Random().nextInt(currentList.length );
    currentWord = currentList[wordIndex];
  }

  void checkWord(int gridIndex) {
    List<int> availableForClick;
    int inWordIndex = selectedLetters.where((element) => element == true).length - 1;
    if (randomizedLetters[gridIndex] != currentWord.name[inWordIndex]) {
      selectedLetters[gridIndex] = false;
      setState(() {});
      showSnackBar("try again", context);
    } else if (inWordIndex == currentWord.name.length - 1) {
      showSnackBar("Correct!", context);
      changeWord('next');
      selectedLetters.fillRange(0, selectedLetters.length, false);
      randomizedLetters = List.generate(25, (index) => ' ');
      appointedWordIndexes.clear();
      setPuzzle();
      setState(() {});
    } else if(randomizedLetters[gridIndex]==currentWord.name[inWordIndex]&&!appointedWordIndexes.sublist(inWordIndex+1).contains(gridIndex)&&(getNeigbourCells(gridIndex)).contains(appointedWordIndexes[inWordIndex+1]-gridIndex)) {  //doğru seçimse ve kelime bitmediyse
      // (harf doğru ve index sonraki appointedalrdan biri değil ve bir sonraki index bu hücre için seçilebilir ise)
      buttonClickable.fillRange(0, buttonClickable.length, false);
      availableForClick = getNeigbourCells(gridIndex);
      for (int l = 0; l < availableForClick.length; l++) {
        buttonClickable[gridIndex + availableForClick[l]] = true;
      }
      setState(() {});
    }
    else { //harf doğru ancak şans eseri
      selectedLetters[gridIndex] = false;
      setState(() {});
      showSnackBar("try again", context);
    }
  }

  List<int> getNeigbourCells(currentGridIndex) {
    List<int> neigbourCells;

    if (currentGridIndex < row) {
      if ((currentGridIndex + 1) % column == 0) {
        neigbourCells = [-1, row]; //top right
      } else if (currentGridIndex % column == 0) {
        neigbourCells = [1, row]; //top left
      } else {
        neigbourCells = [-1, 1, row]; //only top
      }
    } else if (currentGridIndex >= (row - 1) * column) {
      if ((currentGridIndex + 1) % column == 0) {
        neigbourCells = [-1, -row]; //bottom right
      } else if (currentGridIndex % column == 0) {
        neigbourCells = [1, -row]; //bottom left
      } else {
        neigbourCells = [-1, 1, -row]; //only bottom
      }
    } else if ((currentGridIndex + 1) % column == 0) {
      neigbourCells = [-1, -row, row]; //only right
    } else if (currentGridIndex % column == 0) {
      neigbourCells = [1, -row, row]; //only left
    } else {
      neigbourCells = [-1, 1, -row, row]; //not edge
    }

    return neigbourCells;
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
                        onPressed: buttonClickable[index] == true
                            ? () {
                                selectedLetters[index] = true;
                                checkWord(index);
                                setState(() {});
                              }
                            : null,
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
