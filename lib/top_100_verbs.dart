import 'package:deneme1/word_database.dart';

class ConstWord {
  final int id;
  final String name;
  final String meaning;
  final String notes;

  const ConstWord({
    required this.id,
    required this.name,
    required this.meaning,
    required this.notes,
  });

  Word toWord() {
    return Word(id: id, name: name, meaning: meaning, notes: notes);
  }
}

class TopVerbs {
  static const ConstWord sein =
      ConstWord(id: 1, name: 'sein', meaning: 'olmak', notes: 'notes');
  static const ConstWord haben =
      ConstWord(id: 2, name: 'haben', meaning: 'sahip olmak', notes: 'notes');
  static const ConstWord werden =
      ConstWord(id: 3, name: 'werden', meaning: 'olmak', notes: 'notes');
  static const ConstWord konnen =
      ConstWord(id: 4, name: 'können', meaning: 'mümkün olmak', notes: 'notes');
  static const ConstWord machen =
      ConstWord(id: 5, name: 'machen', meaning: 'yapmak', notes: 'notes');
  static const ConstWord mussen =
      ConstWord(id: 6, name: 'müssen', meaning: 'mecbur olmak', notes: 'notes');
  static const ConstWord sagen =
      ConstWord(id: 7, name: 'sagen', meaning: 'söylemek', notes: 'notes');
  static const ConstWord gehen =
      ConstWord(id: 8, name: 'gehen', meaning: 'gitmek', notes: 'notes');
  static const ConstWord geben =
      ConstWord(id: 9, name: 'geben', meaning: 'vermek', notes: 'notes');
  static const ConstWord wollen =
      ConstWord(id: 10, name: 'wollen', meaning: 'istemek', notes: 'notes');

  static const ConstWord kommen =
      ConstWord(id: 11, name: 'kommen', meaning: 'gelmek', notes: 'notes');
  static const ConstWord sollen =
      ConstWord(id: 12, name: 'sollen', meaning: '-meli', notes: 'notes');
  static const ConstWord sehen =
      ConstWord(id: 13, name: 'sehen', meaning: 'görmek', notes: 'notes');
  static const ConstWord mogen =
      ConstWord(id: 14, name: 'mögen', meaning: 'istemek', notes: 'notes');
  static const ConstWord finden =
      ConstWord(id: 15, name: 'finden', meaning: 'bulmak', notes: 'notes');
  static const ConstWord wissen =
      ConstWord(id: 16, name: 'wissen', meaning: 'bilmek', notes: 'notes');
  static const ConstWord glauben =
      ConstWord(id: 17, name: 'glauben', meaning: 'inanmak', notes: 'notes');
  static const ConstWord lernen =
      ConstWord(id: 18, name: 'lernen', meaning: 'öğrenmek', notes: 'notes');
  static const ConstWord durfen = ConstWord(
      id: 19, name: 'dürfen', meaning: 'mümkün olmak', notes: 'notes');
  static const ConstWord denken =
      ConstWord(id: 20, name: 'denken', meaning: 'düşünmek', notes: 'notes');

  static const ConstWord heissen =
      ConstWord(id: 21, name: 'heißen', meaning: 'adı olmak', notes: 'notes');
  static const ConstWord sprechen =
      ConstWord(id: 22, name: 'sprechen', meaning: 'konuşmak', notes: 'notes');
  static const ConstWord tun =
      ConstWord(id: 23, name: 'tun', meaning: 'yapmak', notes: 'notes');
  static const ConstWord fahren =
      ConstWord(id: 24, name: 'fahren', meaning: 'sürmek', notes: 'notes');
  static const ConstWord schreiben =
      ConstWord(id: 25, name: 'schreiben', meaning: 'yazmak', notes: 'notes');
  static const ConstWord lassen = ConstWord(
      id: 26, name: 'lassen', meaning: 'izin vermek, ayrılmak', notes: 'notes');
  static const ConstWord sichFragen = ConstWord(
      id: 27, name: '(sich) fragen', meaning: 'merak etmek', notes: 'notes');
  static const ConstWord bekommen =
      ConstWord(id: 28, name: 'bekommen', meaning: 'almak', notes: 'get');
  static const ConstWord nehmen =
      ConstWord(id: 29, name: 'nehmen', meaning: 'almak', notes: 'take');
  static const ConstWord freuen = ConstWord(
      id: 30, name: '(sich) freuen', meaning: 'mutlu olmak', notes: 'notes');

  static const ConstWord zeigen =
      ConstWord(id: 31, name: 'zeigen', meaning: 'göstermek', notes: 'notes');
  static const ConstWord essen =
      ConstWord(id: 32, name: 'essen', meaning: 'yemek', notes: 'notes');
  static const ConstWord arbeiten =
      ConstWord(id: 33, name: 'arbeiten', meaning: 'çalışmak', notes: 'notes');
  static const ConstWord stehen = ConstWord(
      id: 34, name: 'stehen', meaning: 'ayakta durmak', notes: 'stand');
  static const ConstWord bringen =
      ConstWord(id: 35, name: 'bringen', meaning: 'getirmek', notes: 'notes');
  static const ConstWord kennen =
      ConstWord(id: 36, name: 'kennen', meaning: 'bilmek', notes: 'notes');
  static const ConstWord benutzen =
      ConstWord(id: 37, name: 'benutzen', meaning: 'kullanmak', notes: 'notes');
  static const ConstWord bleiben =
      ConstWord(id: 38, name: 'bleiben', meaning: 'kalmak', notes: 'to stay');
  static const ConstWord leben =
      ConstWord(id: 39, name: 'leben', meaning: 'yaşamak', notes: 'notes');
  static const ConstWord gucken = ConstWord(
      id: 40, name: 'gucken', meaning: 'bakmak', notes: 'to look, to watch');

  static const ConstWord sichStellen = ConstWord(
      id: 41,
      name: '(sich) stellen',
      meaning: 'koymak,yerleştirmek',
      notes: 'notes');
  static const ConstWord horen =
      ConstWord(id: 42, name: 'hören', meaning: 'dinlemek', notes: 'notes');
  static const ConstWord spielen = ConstWord(
      id: 43, name: 'spielen', meaning: 'oynamak,çalmak', notes: 'notes');
  static const ConstWord kaufen =
      ConstWord(id: 44, name: 'kaufen', meaning: 'satın almak', notes: 'notes');
  static const ConstWord passieren =
      ConstWord(id: 45, name: 'passieren', meaning: 'olmak', notes: 'happen');
  static const ConstWord verstehen =
      ConstWord(id: 46, name: 'verstehen', meaning: 'anlamak', notes: 'notes');
  static const ConstWord reden =
      ConstWord(id: 47, name: 'reden', meaning: 'konuşmak', notes: 'notes');
  static const ConstWord schaffen = ConstWord(
      id: 48,
      name: 'schaffen',
      meaning: 'oluşturmak,başarmak,yaratmak',
      notes: 'create,accomplish,manage');
  static const ConstWord halten =
      ConstWord(id: 49, name: 'halten', meaning: 'tutmak', notes: 'keep,hold');
  static const ConstWord trinken =
      ConstWord(id: 50, name: 'trinken', meaning: 'içmek', notes: 'notes');

  static const ConstWord sichTreffen = ConstWord(
      id: 51, name: '(sich) treffen', meaning: 'buluşmak', notes: 'notes');
  static const ConstWord lesen =
      ConstWord(id: 52, name: 'lesen', meaning: 'okumak', notes: 'notes');
  static const ConstWord nennen = ConstWord(
      id: 53,
      name: 'nennen',
      meaning: 'ad koymak,demek',
      notes: 'to name, to call');
  static const ConstWord fuhren = ConstWord(
      id: 54,
      name: 'führen',
      meaning: 'yol göstermek,önderlik etmek',
      notes: 'to lead, to guide');
  static const ConstWord brauchen = ConstWord(
      id: 55, name: 'brauchen', meaning: 'ihtiyaç duymak', notes: 'notes');
  static const ConstWord stimmen = ConstWord(
      id: 56,
      name: 'stimmen',
      meaning: 'akort etmek,doğru olmak,',
      notes: 'to tune, to be correct');
  static const ConstWord wohnen = ConstWord(
      id: 57, name: 'wohnen', meaning: 'oturmak, ikamet etmek', notes: 'notes');
  static const ConstWord helfen = ConstWord(
      id: 58, name: 'helfen', meaning: 'yardım etmek', notes: 'notes');
  static const ConstWord erzahlen = ConstWord(
      id: 59, name: 'erzählen', meaning: 'söylemek,anlatmak', notes: 'to tell');
  static const ConstWord erreichen = ConstWord(
      id: 60,
      name: 'erreichen',
      meaning: 'ulaşmak,yetişmek',
      notes: 'to achieve, to reach');

  static const ConstWord sichVorstellen = ConstWord(
      id: 61,
      name: '(sich) vorstellen',
      meaning: 'hayal etmek',
      notes: 'imagine');
  static const ConstWord ziehen = ConstWord(
      id: 62,
      name: 'ziehen',
      meaning: 'çekmek',
      notes: 'to pull, to draw, to drag');
  static const ConstWord versuchen =
      ConstWord(id: 63, name: 'versuchen', meaning: 'denemek', notes: 'notes');
  static const ConstWord laufen =
      ConstWord(id: 64, name: 'laufen', meaning: 'koşmak', notes: 'notes');
  static const ConstWord gewinnen = ConstWord(
      id: 65, name: 'gewinnen', meaning: 'kazanmak', notes: 'to win,to gain');
  static const ConstWord suchen =
      ConstWord(id: 66, name: 'suchen', meaning: 'araştırmak', notes: 'search');
  static const ConstWord erklaren = ConstWord(
      id: 67, name: 'erklären', meaning: 'açıklamak', notes: 'explain');
  static const ConstWord sichEntscheiden = ConstWord(
      id: 68,
      name: '(sich) entscheiden',
      meaning: 'karar vermek',
      notes: 'to decide');
  static const ConstWord wahlen =
      ConstWord(id: 69, name: 'wählen', meaning: 'seçmek', notes: 'to choose');
  static const ConstWord liegen = ConstWord(
      id: 70, name: 'liegen', meaning: 'uzanmak,yatmak', notes: 'liege');

  static const ConstWord meinen = ConstWord(
      id: 71, name: 'meinen', meaning: 'düşünmek', notes: 'to think, to mean');
  static const ConstWord verlieren = ConstWord(
      id: 72, name: 'verlieren', meaning: 'kaybetmek', notes: 'to lose');
  static const ConstWord studieren =
      ConstWord(id: 73, name: 'studieren', meaning: 'çalışmak', notes: 'notes');
  static const ConstWord sichSetzen = ConstWord(
      id: 74, name: '(sich) setzen', meaning: 'oturmak', notes: 'notes');
  static const ConstWord hoffen =
      ConstWord(id: 75, name: 'hoffen', meaning: 'umut etmek', notes: 'notes');
  static const ConstWord vergessen =
      ConstWord(id: 76, name: 'vergessen', meaning: 'unutmak', notes: 'notes');
  static const ConstWord sitzen =
      ConstWord(id: 77, name: 'sitzen', meaning: 'oturmak', notes: 'notes');
  static const ConstWord einladen = ConstWord(
      id: 78, name: 'einladen', meaning: 'davet etmek', notes: 'to invite');
  static const ConstWord beschreiben = ConstWord(
      id: 79, name: 'beschreiben', meaning: 'betimlemek', notes: 'to describe');
  static const ConstWord anSchauen =
      ConstWord(id: 80, name: '(an)schauen', meaning: 'bakmak', notes: 'notes');

  static const ConstWord andern = ConstWord(
      id: 81, name: 'Ändern', meaning: 'değişmek,değiştirmek', notes: 'notes');
  static const ConstWord besuchen = ConstWord(
      id: 82, name: 'besuchen', meaning: 'ziyaret etmek', notes: 'to visit');
  static const ConstWord nutzen =
      ConstWord(id: 83, name: 'nutzen', meaning: 'kullanmak', notes: 'to use');
  static const ConstWord kochen =
      ConstWord(id: 84, name: 'kochen', meaning: 'pişirmek', notes: 'to cook');
  static const ConstWord feiern = ConstWord(
      id: 85, name: 'feiern', meaning: 'kutlamak', notes: 'to celebrate');
  static const ConstWord fallen =
      ConstWord(id: 86, name: 'fallen', meaning: 'düşmek', notes: 'notes');
  static const ConstWord bauen = ConstWord(
      id: 87, name: 'bauen', meaning: 'inşa etmek', notes: 'to build');
  static const ConstWord entwickeln = ConstWord(
      id: 88, name: 'entwickeln', meaning: 'geliştirmek', notes: 'to develop');
  static const ConstWord erwarten = ConstWord(
      id: 89, name: 'erwarten', meaning: 'beklemek', notes: 'to expect');
  static const ConstWord bezahlen =
      ConstWord(id: 90, name: 'bezahlen', meaning: 'ödemek', notes: 'to pay');

  static const ConstWord verkaufen =
      ConstWord(id: 91, name: 'verkaufen', meaning: 'satmak', notes: 'to sell');
  static const ConstWord tragen = ConstWord(
      id: 92,
      name: 'tragen',
      meaning: 'taşımak,giymek',
      notes: 'to carry,to wear');
  static const ConstWord planen = ConstWord(
      id: 93,
      name: 'planen',
      meaning: 'plan yapmak,tasarlamak',
      notes: 'notes');
  static const ConstWord danken = ConstWord(
      id: 94, name: 'danken', meaning: 'teşekkür etmek', notes: 'notes');
  static const ConstWord sichFuhlen = ConstWord(
      id: 95, name: '(sich) fühlen', meaning: 'hissetmek', notes: 'to feel');
  static const ConstWord ubernehmen = ConstWord(
      id: 96,
      name: 'übernehmen',
      meaning: 'devralmak,kabul etmek',
      notes: 'to take over, to adopt');
  static const ConstWord sichErinnern = ConstWord(
      id: 97,
      name: '(sich) erinnern',
      meaning: ' hatırla(t)mak',
      notes: 'notes');
  static const ConstWord merken = ConstWord(
      id: 98,
      name: 'merken',
      meaning: 'farkına varmak',
      notes: 'to notice,to realize');
  static const ConstWord lieben =
      ConstWord(id: 99, name: 'lieben', meaning: 'sevmek', notes: 'love');
  static const ConstWord erkennen = ConstWord(
      id: 100,
      name: 'erkennen',
      meaning: 'tanımak,anlamak',
      notes: 'to recognize,to realize');

  static List<Word> top100VerbsasWord = [
    sein.toWord(),
    haben.toWord(),
    werden.toWord(),
    konnen.toWord(),
    machen.toWord(),
    mussen.toWord(),
    sagen.toWord(),
    gehen.toWord(),
    geben.toWord(),
    wollen.toWord(),
    kommen.toWord(),
    sollen.toWord(),
    sehen.toWord(),
    mogen.toWord(),
    finden.toWord(),
    wissen.toWord(),
    glauben.toWord(),
    lernen.toWord(),
    durfen.toWord(),
    denken.toWord(),
    heissen.toWord(),
    sprechen.toWord(),
    tun.toWord(),
    fahren.toWord(),
    schreiben.toWord(),
    lassen.toWord(),
    sichFragen.toWord(),
    bekommen.toWord(),
    nehmen.toWord(),
    freuen.toWord(),
    zeigen.toWord(),
    essen.toWord(),
    arbeiten.toWord(),
    stehen.toWord(),
    bringen.toWord(),
    kennen.toWord(),
    benutzen.toWord(),
    bleiben.toWord(),
    leben.toWord(),
    gucken.toWord(),
    sichStellen.toWord(),
    horen.toWord(),
    spielen.toWord(),
    kaufen.toWord(),
    passieren.toWord(),
    verstehen.toWord(),
    reden.toWord(),
    schaffen.toWord(),
    halten.toWord(),
    trinken.toWord(),
    sichTreffen.toWord(),
    lesen.toWord(),
    nennen.toWord(),
    fuhren.toWord(),
    brauchen.toWord(),
    stimmen.toWord(),
    wohnen.toWord(),
    helfen.toWord(),
    erzahlen.toWord(),
    erreichen.toWord(),
    sichVorstellen.toWord(),
    ziehen.toWord(),
    versuchen.toWord(),
    laufen.toWord(),
    gewinnen.toWord(),
    suchen.toWord(),
    erklaren.toWord(),
    sichEntscheiden.toWord(),
    wahlen.toWord(),
    liegen.toWord(),
    meinen.toWord(),
    verlieren.toWord(),
    studieren.toWord(),
    sichSetzen.toWord(),
    hoffen.toWord(),
    vergessen.toWord(),
    sitzen.toWord(),
    einladen.toWord(),
    beschreiben.toWord(),
    anSchauen.toWord(),
    andern.toWord(),
    besuchen.toWord(),
    nutzen.toWord(),
    kochen.toWord(),
    feiern.toWord(),
    fallen.toWord(),
    bauen.toWord(),
    entwickeln.toWord(),
    erwarten.toWord(),
    bezahlen.toWord(),
    verkaufen.toWord(),
    tragen.toWord(),
    planen.toWord(),
    danken.toWord(),
    sichFuhlen.toWord(),
    ubernehmen.toWord(),
    sichErinnern.toWord(),
    merken.toWord(),
    lieben.toWord(),
    erkennen.toWord(),
  ];

  static const List<ConstWord> top100Verbs = [
    sein,
    haben,
    werden,
    konnen,
    machen,
    mussen,
    sagen,
    gehen,
    geben,
    wollen,
    kommen,
    sollen,
    sehen,
    mogen,
    finden,
    wissen,
    glauben,
    lernen,
    durfen,
    denken,
    heissen,
    sprechen,
    tun,
    fahren,
    schreiben,
    lassen,
    sichFragen,
    bekommen,
    nehmen,
    freuen,
    zeigen,
    essen,
    arbeiten,
    stehen,
    bringen,
    kennen,
    benutzen,
    bleiben,
    leben,
    gucken,
    sichStellen,
    horen,
    spielen,
    kaufen,
    passieren,
    verstehen,
    reden,
    schaffen,
    halten,
    trinken,
    sichTreffen,
    lesen,
    nennen,
    fuhren,
    brauchen,
    stimmen,
    wohnen,
    helfen,
    erzahlen,
    erreichen,
    sichVorstellen,
    ziehen,
    versuchen,
    laufen,
    gewinnen,
    suchen,
    erklaren,
    sichEntscheiden,
    wahlen,
    liegen,
    meinen,
    verlieren,
    studieren,
    sichSetzen,
    hoffen,
    vergessen,
    sitzen,
    einladen,
    beschreiben,
    anSchauen,
    andern,
    besuchen,
    nutzen,
    kochen,
    feiern,
    fallen,
    bauen,
    entwickeln,
    erwarten,
    bezahlen,
    verkaufen,
    tragen,
    planen,
    danken,
    sichFuhlen,
    ubernehmen,
    sichErinnern,
    merken,
    lieben,
    erkennen,
  ];
}
