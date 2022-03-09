import 'package:deneme1/word_card_widget.dart';
import 'package:deneme1/word_database.dart';
import 'package:flutter/material.dart';

class FavWordsListPage extends StatefulWidget {
  const FavWordsListPage({required Key key}) : super(key: key);
  @override
  _FavWordListPageState createState() => _FavWordListPageState();
}

class _FavWordListPageState extends State<FavWordsListPage> {
  List<Word> words = [];

  @override
  void initState() {
    super.initState();
    WordDatabase.instance.queryFavWords().then((List<Word> value) {
      setState(() {
        words = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
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
                        await WordDatabase.instance.deleteWord(words[index].id);
                        WordDatabase.instance
                            .queryFavWords()
                            .then((List<Word> value) {
                          setState(() {
                            words = value;
                          });
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
              word: words[index],
              key: Key(words[index].name),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
