import 'package:deneme1/top_100_verbs.dart';
import 'package:deneme1/word_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PracticeSlides2 extends StatefulWidget {
  const PracticeSlides2({Key? key}) : super(key: key);

  @override
  State<PracticeSlides2> createState() => _PracticeSlidesState2();
}

class _PracticeSlidesState2 extends State<PracticeSlides2> {
  List<Word> words = [];
  double appBarHeight = AppBar().preferredSize.height;
  int wordIndex = 0;
  Word currentWord = Word(id: 1, name: '', meaning: '', notes: '');
  final List<Word> _top100Verbs = TopVerbs.top100VerbsasWord;
  String _selectedList = 'Top 100 Verbs';
  List<Word> currentList = TopVerbs.top100VerbsasWord;
  static const List<String> _menuItems = ['My Words', 'Top 100 Verbs'];
  DraggableScrollableController scrollableController =
      DraggableScrollableController();
  bool inOrder = true;
  String webResponse = 'NÖ';
  String proN = '';

  final List<DropdownMenuItem<String>> _dropDownMenu = _menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  @override
  void initState() {
    WordDatabase.instance.queryAllWords().then((List<Word> value) {
      setState(() {
        words = value;
        currentWord = words.first;
      });
    });
    selectList();
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

  void changeWord(String direction)   {
    if (inOrder) {  //TODO: check whether this cond. must be reversed or not
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

  Future<void> getWebResponse() async {
    //var uri = Uri.https('example.org', '/path', {'q': 'dart'});
    //print(uri); // https://example.org/path?q=dart
    var client = http.Client();
    var url2 = '/api/ipa/?q=Boot';
    var url1 = '/r/?q=${currentWord.name}&view=csv';
    try {
      var response = await client.post(
        Uri.parse('https://www.dwds.de/api/ipa/?q=${currentWord.name}'),
      );
      proN  = jsonDecode(utf8.decode(response.bodyBytes))[0]['ipa'];
 
    } finally {
      client.close();
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
            color: Theme.of(context).primaryColor,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        title: const Text(
                          'The word set:',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: DropdownButton(
                            style: const TextStyle(color: Colors.white),
                            dropdownColor: Theme.of(context).primaryColor,
                            value: _selectedList,
                            items: _dropDownMenu,
                            onChanged: (String? newList) {
                              if (newList != null) {
                                setState(() {
                                  _selectedList = newList;
                                  selectList();
                                });
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  inOrder = !inOrder;
                                });
                              },
                              icon: const Icon(
                                Icons.shuffle,
                              ),
                              color: inOrder == true
                                  ? Theme.of(context).primaryColorDark
                                  : Colors.white,
                            ),
                            PopupMenuButton(
                              icon: const Icon(
                                Icons.list,
                                color: Colors.white,
                              ),
                              color: Theme.of(context).primaryColor,
                              itemBuilder: (context) {
                                return currentList.map((e) {
                                  return PopupMenuItem(
                                    value: e.name,
                                    child: Text(
                                      e.name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList();
                              },
                              onSelected: (word) {
                                if (word != null) {
                                  setState(() {
                                    wordIndex = currentList.indexWhere(
                                        (element) => element.name == word);
                                    currentWord = currentList[wordIndex];
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            currentWord.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              //backgroundColor: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              currentWord.meaning,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                //backgroundColor: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          proN,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            //backgroundColor: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ), //kelimenin olduğu arka mekan
          DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.2,
              maxChildSize: 0.7,
              snap: false,
              controller: scrollableController,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ListView(
                  controller: scrollController,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18.0),
                            ),
                            color: Theme.of(context).cardColor,
                          ),
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.7 -
                                    appBarHeight,
                            maxWidth: MediaQuery.of(context).size.width,
                          ),
                          child: Column(
                            //bu column expanded sadece column,row ya da flex parent istediği için
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.white,
                                size: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 12),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.white,
                  onPressed: ()  async {
                     changeWord('previous');
                     _snapToInitialSize(scrollableController);
                    await getWebResponse().then((value) {
                      setState(() {});
                    });
                    
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left_sharp,
                    size: 40,
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: ()  async {
                     changeWord('next');
                    await getWebResponse();
                    _snapToInitialSize(scrollableController).then((value) {
                      setState(() {});
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _snapToInitialSize(
      DraggableScrollableController scrollController) async {
    await scrollController.animateTo(
      0.7,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInCubic,
    );
  }
}
