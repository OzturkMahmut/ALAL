import 'package:animations/animations.dart';
import 'package:deneme1/my_words/my_words_all_words_page.dart';
import 'package:deneme1/my_words/my_words_fav_words_page.dart';
import 'package:deneme1/my_words/my_words_search_page.dart';
import 'package:flutter/material.dart';
import '../add_word.dart';
import '../new_words_storage.dart';
import '../word_database.dart';


void main() {
  runApp(
    MyWordsFul(
      storage: WordStorage(),
      title: 'ALAL',
    ),
  );
}

class MyWords extends StatelessWidget {
  const MyWords({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALAL',
      home: MyWordsFul(
        storage: WordStorage(),
        title: 'ALAL',
      ),
    );
  }
}

class MyWordsFul extends StatefulWidget {
  const MyWordsFul({
    Key? key,
    required this.title,
    required this.storage,
  }) : super(key: key);

  final WordStorage storage;
  final String title;

  @override
  _MyWordsFulState createState() => _MyWordsFulState();
}

class _MyWordsFulState extends State<MyWordsFul> {
  List<Word> words = [];
  int _pageIndex = 0;

  final _pageList = <Widget>[
    AllWordsListPage(key: UniqueKey()),
    FavWordsListPage(key: UniqueKey()),
    SearchPage(key: UniqueKey()),
  ];

  @override
  void initState() {
    super.initState();
    WordDatabase.instance.queryAllWords().then((List<Word> value) {
      setState(() {
        words = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Words'),
      ),
      body: SafeArea(
        //appbarı kaldırırsan içerik status barın altına taşmasın diye
        child: PageTransitionSwitcher(
          transitionBuilder: (
            child,
            animation,
            secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _pageList[_pageIndex],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        //extended yapınca şekli değişti

        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddWordFul(
                      title: 'ALAL',
                      storage: WordStorage(),
                    )),
          );
          //await WordDatabase.instance.addColumn('isFav');
        },

        label: const Text('Add A word!'),
        icon: const Icon(Icons.add), //extenden olduğu için widget yerine label
        tooltip: 'Add A Word',
        elevation: 10, //z koordinatı, gölgenin keskinliğini belirliyo
      ),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor:const Color.fromARGB(255, 61, 64, 91,),
        currentIndex: _pageIndex,
        onTap: (selectedIndex) {
          setState(() {
            _pageIndex = selectedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.all_inclusive,
            ),
            label: 'ALL',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              //color: CustomColors.terraCota,
            ),
            label: 'FAVORITES',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              //color: CustomColors.terraCota,
            ),
            label: 'SEARCH',
          ),
        ],
      ),
    );
  }
}
