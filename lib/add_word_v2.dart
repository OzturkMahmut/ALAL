import 'package:flutter/material.dart';
import 'new_words_storage.dart';
import 'word_database.dart';
import 'dart:math'; //random kelime için
import 'package:translator/translator.dart';

void main() {
  runApp(
    AddWord2Ful(
      storage: WordStorage(),
      title: 'ALAL',
    ),
  );
}

class AddWord2 extends StatelessWidget {
  const AddWord2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALAL',
      home: AddWord2Ful(storage: WordStorage(), title: 'ALAL'),
    );
  }
}

class AddWord2Ful extends StatefulWidget {
  const AddWord2Ful({Key? key, required this.title, required this.storage})
      : super(key: key);

  final WordStorage storage;
  final String title;

  @override
  _AddWord2FulState createState() => _AddWord2FulState();
}

class _AddWord2FulState extends State<AddWord2Ful>
    with TickerProviderStateMixin {
  Word newWord = Word(id: 9, name: '', meaning: '', notes: '', isFav: 0);
  late FocusNode _name, _meaning, _notes;
  final translator = GoogleTranslator();
  String _translation = '';
  String fromLan = 'en';
  String toLan = 'de';
  final TextEditingController _txt = TextEditingController();
  double _begin = 0.50;

  @override
  void initState() {
    super.initState();
    _name = FocusNode();
    _meaning = FocusNode();
    _notes = FocusNode();
  }

  @override
  void dispose() {
    _name.dispose();
    _meaning.dispose();
    _notes.dispose();
    _txt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Words'),
        ),
        body: Form(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //-------------- TEST İÇİN>
                      ElevatedButton(
                        onPressed: () {
                          _addTenRandomWords();
                        },
                        child: const Text('Add 10 Random Words'),
                      ),
                      // <TEST İÇİN  ---------------
                      TextFormField(
                        autofocus: true, //sayfa açılır açılmaa odaklanıyor.
                        decoration: InputDecoration(
                          hintText: 'Enter the new word ($fromLan)',
                          icon: const Icon(
                            Icons.toll_sharp,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                            ),
                            onPressed: () async {
                              await translator
                                  .translate(
                                newWord.name,
                                from: fromLan,
                                to: toLan,
                              )
                                  .then((s) {
                                setState(() {
                                  _translation = s.toString();
                                  _txt.text = _translation;
                                });
                              });
                            },
                          ),
                        ),
                        onChanged: (String? value) async {
                          newWord.name = value!;
                        },
                        onFieldSubmitted: (String? value) async {
                          newWord.name = value!;

                          await translator
                              .translate(
                            newWord.name,
                            from: fromLan,
                            to: toLan,
                          )
                              .then((s) {
                            setState(() {
                              _translation = s.toString();
                              _txt.text = _translation;
                            });
                          });

                          _meaning.requestFocus();
                          //widget.storage.writeWord(value.toString());
                        },
                      ),
                      IconButton(
                        icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            transitionBuilder: (child, anim) =>
                                RotationTransition(
                                  turns: child.key == const ValueKey('icon1')
                                      ? Tween<double>(begin: _begin, end: 0.50)
                                          .animate(anim)
                                      : Tween<double>(begin: _begin, end: 1)
                                          .animate(anim),
                                  child: ScaleTransition(
                                      scale: anim, child: child),
                                ),
                            child: _begin == 0.50
                                ? const Icon(Icons.swap_horiz_outlined,
                                    key: ValueKey('icon1'))
                                : const Icon(
                                    Icons.swap_horiz_outlined,
                                    key: ValueKey('icon2'),
                                  )),
                        onPressed: () {
                          setState(() {
                            _begin = _begin == 0.50 ? 1 : 0.50;
                            fromLan = fromLan == 'en' ? 'de' : 'en';
                            toLan = toLan == 'en' ? 'de' : 'en';
                          });
                        },
                      ),

                      TextFormField(
                        controller: _txt,
                        focusNode: _meaning,
                        decoration: InputDecoration(
                          hintText: 'Enter the meaning ($toLan)',
                          icon: const Icon(
                            Icons.toll_sharp,
                          ),
                        ),
                        onFieldSubmitted: (String? value) {
                          newWord.meaning = value!;
                          _notes.requestFocus();

                          //widget.storage.writeWord(value.toString());
                        },
                      ),
                      TextFormField(
                        focusNode: _notes,
                        decoration: const InputDecoration(
                          hintText: 'Notes(Optional)',
                          icon: Icon(
                            Icons.toll_sharp,
                          ),
                        ),
                        onFieldSubmitted: (String? value) {
                          newWord.notes = value!;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              newWord.isFav = newWord.isFav == 1 ? 0 : 1;
                              setState(() {});
                            },
                            child: Text(
                              'Add To Favorites',
                              style: TextStyle(
                                color: newWord.isFav == 1
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          IconButton(
                              color: newWord.isFav == 1
                                  ? Colors.red
                                  : Theme.of(context).primaryColor,
                              onPressed: () {
                                newWord.isFav = newWord.isFav == 1 ? 0 : 1;
                                setState(() {});
                              },
                              icon: const Icon(Icons.favorite)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _saveWord(newWord);
                        },
                        child: const Text('Submit'),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}

_saveWord(Word word) async {
  WordDatabase helper = WordDatabase.instance;
  final List<Word> maps = await helper.queryAllWords();
  int nextid = maps.isEmpty ? 1 : maps[maps.length - 1].id + 1;
  word.id = nextid;
  // ignore: unused_local_variable
  int id = await helper.insertWord(word);
  //print('inserted row: ${maps.length + 1} , id:$id');
}

//*******test için
_addTenRandomWords() async {
  for (var x = 0; x < 10; x++) {
    var r = Random();
    var ranWord = Word(
      id: 1,
      name: generateRandomString(10),
      meaning: generateRandomString(10),
      notes: generateRandomString(10),
      isFav: r.nextInt(2),
    );

    await _saveWord(ranWord);
  }
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
// test için*******

