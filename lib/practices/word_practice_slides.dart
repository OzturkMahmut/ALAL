import 'package:deneme1/themes/theme_colors.dart';
import 'package:deneme1/word_card_widget.dart';
import 'package:deneme1/word_database.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class PracticeSlides extends StatefulWidget {
  const PracticeSlides({Key? key}) : super(key: key);

  @override
  State<PracticeSlides> createState() => _PracticeSlidesState();
}

class _PracticeSlidesState extends State<PracticeSlides> {
  List<Word> words = [];

  @override
  void initState() {
    WordDatabase.instance.queryAllWords().then((List<Word> value) {
      setState(() {
        words = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(
          Size(MediaQuery.of(context).size.width / 20, 170.0)),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          //return WordCard(key: UniqueKey(), word: words[index]);
          //belki constrainedBox
          //OverflowBox hata göstertmiyor
          return Container(
            //color: Theme.of(context).primaryColor,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                words[index].name,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: CustomColors.eggshell,
                ),
              ),
              Text(
                words[index].meaning,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: CustomColors.eggshell,
                ),
              ),
              ],
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                )),
          );
        },
        itemCount: words.length,
        itemWidth: 400.0,
        itemHeight: 400.0,
        layout: SwiperLayout.TINDER,
      ),
    );
  }
}
