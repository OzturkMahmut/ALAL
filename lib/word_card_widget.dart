import 'package:deneme1/word_database.dart';
import 'package:flutter/material.dart';


class WordCard extends StatefulWidget {
   const WordCard({
    required Key key,
    required this.word,
  }) : super(key: key);

  final Word word;

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends  State<WordCard>  {
  Color favColor = Colors.red;
  Color notFavColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        //color: CustomColors.terraCota,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        
      //TODO:   https://api.flutter.dev/flutter/widgets/Row-class.html, 
      //layout algorithm step1,
      //alltaki 'burası' yazan columnda crossaxisalignment incoming max height 
      //constrainti olmadığı için end için gittiği en uç sağ ekrandan taşıyor olabilir
      //buraya bir constraint koy mainaxis için
        children: [
          //Yazıların olduğu sol column
          Expanded(
            //expanded çünkü kelime çok uzunsa taşma olmasın alta yazsın diye.
            child: Column(
              //axisAlign lar kullanarak textin yerini belirledim.
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //KELİME
                  'Word: ${widget.word.name}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  //ANLAMI
                  'Meaning: ${widget.word.meaning}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  //KELİME HAKKINDA NOTLAR
                  'Notes: ${widget.word.notes}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Column(
            //Simgelerin Olduğu Sağ Column
            crossAxisAlignment: CrossAxisAlignment.end, //burası
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                color: Colors.white,
                onPressed: () async {
                  // kelime SİLME FONKSİYONU
                  await WordDatabase.instance
                      .deleteWord(widget.word.id)
                      .then((value) {
                    setState(() {
                    //notifyListeners();  
                    widget.word.name='';
                    });
                  });
                },
                icon: const Icon(Icons.highlight_remove_outlined),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                color: widget.word.isFav == 1 ? favColor : notFavColor,
                onPressed: () async {
                  widget.word.isFav = widget.word.isFav == 1 ? 0 : 1;
                  await WordDatabase.instance
                      .updateWord(widget.word)
                      .then((value) {
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.favorite),
              )
            ],
          )
        ],
      ),
    );
  }
}
