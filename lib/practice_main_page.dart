import 'package:animations/animations.dart';
import 'package:deneme1/drops_snake_practice.dart';
import 'package:deneme1/word_practice_slides.dart';
import 'package:deneme1/word_practice_slides2.dart';
import 'package:flutter/material.dart';
import 'new_words_storage.dart';
import 'word_card_widget.dart';
import 'word_database.dart';
import 'package:deneme1/themes/theme_colors.dart';
import 'top_100_verbs.dart';

void main() {
  runApp(
    PracticeFul(
      storage: WordStorage(),
      title: 'ALAL',
    ),
  );
}

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALAL',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PracticeFul(
        storage: WordStorage(),
        title: 'ALAL',
      ),
    );
  }
}

class PracticeFul extends StatefulWidget {
  const PracticeFul({
    Key? key,
    required this.title,
    required this.storage,
  }) : super(key: key);

  final WordStorage storage;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PracticeFulState createState() => _PracticeFulState();
}

class _PracticeFulState extends State<PracticeFul> {
  List<ConstWord> words = [];
  List<ConstWord> top99Verbs = TopVerbs.top100Verbs;
  int _pageIndex = 0;

  final _pageList = <Widget>[
    AllWordsListPage2(key: UniqueKey()),
    FavWordsListPage2(
      key: UniqueKey(),
    ),
    SearchPage2(key: UniqueKey()),
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      words = top99Verbs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.independence,
      appBar: AppBar(
        
        title: const Text('TOP 99 VERBS'),
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
        heroTag: UniqueKey(),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DropsSnake()),
          );
          //await WordDatabase.instance.addColumn('isFav');
        },
        
        label: const Text('Slide Practice!'),
        icon: const Icon(Icons.add), //extenden olduğu için widget yerine label
        tooltip: 'Slide Practice',
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
              
            ),
            label: 'FAVORITES',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              
            ),
            label: 'SEARCH',
          ),
        ],
      ),
    );
  }
}

class FavWordsListPage2 extends StatefulWidget {
  const FavWordsListPage2({required Key key}) : super(key: key);
  @override
  _FavWordListPageState2 createState() => _FavWordListPageState2();
}

class _FavWordListPageState2 extends State<FavWordsListPage2> {
  List<ConstWord> words = [];
  List<ConstWord> top99Verbs = TopVerbs.top100Verbs;

  @override
  void initState() {
    super.initState();
    setState(() {
      words = top99Verbs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(words[index].name),
            confirmDismiss: (direction) async {
              // onDissmissed gibi ama veto hakkı veriyor.
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Kelimeyi Sil'),
                  content: const Text('Kelimeyi Silmek İstiyor musun?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'İptal ');
                      },
                      child: const Text('İptal'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {});

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('word  is deleted')));
                        Navigator.pop(context, 'Sil');
                      },
                      child: const Text('Sil'),
                    ),
                  ],
                ),
              );
              return null;
            },
            background: Container(color: Colors.red),
            child: WordCard(
              word: Word(id:1, name:words[index].name, meaning:words[index].meaning ,notes:words[index].notes ,isFav: 0),
              key: Key(words[index].name),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

class AllWordsListPage2 extends StatefulWidget {
  const AllWordsListPage2({required Key key}) : super(key: key);
  @override
  _AllWordsListPageState2 createState() => _AllWordsListPageState2();
}

class _AllWordsListPageState2 extends State<AllWordsListPage2> {
  List<ConstWord> words = [];
  List<ConstWord> top99Verbs = TopVerbs.top100Verbs;

  @override
  void initState() {
    super.initState();
    setState(() {
      words = top99Verbs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(words[index].name),
            confirmDismiss: (direction) async {
              // onDissmissed gibi ama veto hakkı veriyor.
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Kelimeyi Sil'),
                  content: const Text('Kelimeyi Silmek İstiyor musun?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'İptal ');
                      },
                      child: const Text('İptal'),
                    ),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          words = top99Verbs;
                        });

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('word  is deleted')));
                        Navigator.pop(context, 'Sil');
                      },
                      child: const Text('Sil'),
                    ),
                  ],
                ),
              );
              return null;
            },
            background: Container(color: Colors.red),
            child: WordCard(
              word: Word(id:1, name:words[index].name, meaning:words[index].meaning ,notes:words[index].notes ,isFav: 0),
              key: Key(words[index].name),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

class SearchPage2 extends StatefulWidget {
  const SearchPage2({required Key key}) : super(key: key);
  @override
  _SearchPageState2 createState() => _SearchPageState2();
}

class _SearchPageState2 extends State<SearchPage2> {
  List<ConstWord> words = [];
  List<ConstWord> top99Verbs = TopVerbs.top100Verbs;

  @override
  void initState() {
    super.initState();

    setState(() {
      words = top99Verbs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(words[index].name),
            confirmDismiss: (direction) async {
              // onDissmissed gibi ama veto hakkı veriyor.
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Kelimeyi Sil'),
                  content: const Text('Kelimeyi Silmek İstiyor musun?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'İptal ');
                      },
                      child: const Text('İptal'),
                    ),
                    TextButton(
                      onPressed: () async {
                        setState(() {});

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('word  is deleted')));
                        Navigator.pop(context, 'Sil');
                      },
                      child: const Text('Sil'),
                    ),
                  ],
                ),
              );
              return null;
            },
            background: Container(color: Colors.red),
            child: WordCard(
              word: Word(id:1, name:words[index].name, meaning:words[index].meaning ,notes:words[index].notes ,isFav: 0),
              key: Key(words[index].name),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
