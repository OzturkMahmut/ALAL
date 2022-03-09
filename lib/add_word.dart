import 'package:flutter/material.dart';
import 'new_words_storage.dart';
import 'word_database.dart';
import 'dart:math'; //random kelime için
import 'package:deneme1/themes/theme_colors.dart';

void main() {
  runApp(
    AddWordFul(
      storage: WordStorage(),
      title: 'ALAL',
    ),
  );
}

class AddWord extends StatelessWidget {
  const AddWord({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALAL',
      home: AddWordFul(storage: WordStorage(), title: 'ALAL'),
    );
  }
}

class AddWordFul extends StatefulWidget {
  const AddWordFul({Key? key, required this.title, required this.storage})
      : super(key: key);

  final WordStorage storage;

  final String title;

  @override
  _AddWordFulState createState() => _AddWordFulState();
}

class _AddWordFulState extends State<AddWordFul> {
  Word newWord = Word(id: 9, name: '', meaning: '', notes: '', isFav: 0);

  late FocusNode _name, _meaning, _notes;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.greenSheen,
        appBar: AppBar(
          backgroundColor: CustomColors.greenSheen,
          title: const Text('Add Words'),
        ),
        body: Form(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //-------------- TEST İÇİN>
                    ElevatedButton(
                      onPressed: () {
                        _addTenRandomWords();
                      },
                      child: const Text('Add 10 Random Words'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                        CustomColors.terraCota,
                      )),
                    ),
                    // <TEST İÇİN  ---------------
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      autofocus: true, //sayfa açılır açılmaa odaklanıyor.
                      decoration: const InputDecoration(
                        hintText: 'Enter the new word',
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.toll_sharp,
                          color: CustomColors.terraCota,
                        ),
                      ),

                      onFieldSubmitted: (String? value) {
                        newWord.name = value!;
                        _meaning.requestFocus();
                        //widget.storage.writeWord(value.toString());
                      },
                    ),
                    TextFormField(
                      focusNode:
                          _meaning, //sayfa açılır açılmaz alana odaklanıyor.
                      decoration: const InputDecoration(
                        hintText: 'Enter the meaning',
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.toll_sharp,
                          color: CustomColors.terraCota,
                        ),
                      ),

                      onFieldSubmitted: (String? value) {
                        newWord.meaning = value!;
                        _notes.requestFocus();

                        //widget.storage.writeWord(value.toString());
                      },
                    ),
                    TextFormField(
                      focusNode:
                          _notes, //sayfa açılır açılmaz alana odaklanıyor.
                      decoration: const InputDecoration(
                        hintText: 'Notes(Optional)',
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.toll_sharp,
                          color: CustomColors.terraCota,
                        ),
                      ),

                      onFieldSubmitted: (String? value) {
                        newWord.notes = value!;
                        //widget.storage.writeWord(value.toString());
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       
                        TextButton(
                          onPressed: (){
                            newWord.isFav = newWord.isFav == 1 ? 0 : 1;
                              setState(() {});
                          },
                          child: Text(
                          'Add To Favorites',
                          style: TextStyle(
                              color: (newWord.isFav == 1
                                  ? Colors.red
                                  : Colors.white)),
                        ),),
                        IconButton(
                            color:
                                newWord.isFav == 1 ? Colors.red : Colors.white,
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
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                        CustomColors.terraCota,
                      )),
                    ),
                  ]),
            ),
          ),
        ));
  }
}

_saveWord(Word word) async {
  WordDatabase helper = WordDatabase.instance;
  final List<Word> maps = await helper.queryAllWords();
  int nextid = maps[maps.length-1].id+1;
  word.id = nextid;
  // ignore: unused_local_variable
  int id = await helper.insertWord(word);
  //print('inserted row: ${maps.length+1} , id:$id');
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





