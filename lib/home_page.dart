import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'add_word.dart';
import 'add_word_v2.dart';
import 'my_words/my_words_main.dart';
import 'new_words_storage.dart';
import 'practice_main_page.dart';
import 'settings.dart';

void main() {
  runApp(const MyHomePageFul(
    title: 'ALAL',
  ));
}

class MyHomePageFul extends StatefulWidget {
  const MyHomePageFul({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageFul> {
  static const options = ['Kelimelerim', 'Pratik Yap', 'Kelime Ekle'];
  String? _userName = "";
  String _userEmail = '';
  String _photoUrl = ' ';
  //late object.User user ;

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
    //addData();
  }

 /* addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false );
    await _userProvider.refreshUser();
  }
*/

  void getCurrentUserData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      _userName = (snap.data() as Map<String, dynamic>)['username'];
      _userEmail = (snap.data() as Map<String, dynamic>)['email'];
      _photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  @override
  Widget build(BuildContext context) {

   // user = Provider.of<UserProvider>(context).getUser;

    var drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        'Kullanıcı Adı: $_userName',
      ),
      accountEmail: Text(
        'Email: $_userEmail',
      ),
      currentAccountPicture: CircleAvatar(
        radius: 64,
        backgroundImage: NetworkImage(_photoUrl),
      ),
    );
    final draweritems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: const Text(
            '',
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text(
            '',
          ),
          leading: const Icon(Icons.comment),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text(
            'Sign out ',
          ),
          leading: const Icon(Icons.logout_sharp),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SettingsPageFul()),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, //her kutucuk eşit yer kaplasın
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            //İLK BÖLME
            Expanded(
              // kutucuk kendine verilen alanın hepsini kaplasın diye
              child: GestureDetector(
                //containeın her pixelini tıklanabilir yapmak için
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyWordsFul(
                              title: 'ALAL',
                              storage: WordStorage(),
                            )),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Text(
                      options[0],
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
            //ARALIK
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
            ),
            //İKİNCİ BÖLME
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PracticeFul(
                              title: 'ALAL',
                              storage: WordStorage(),
                            )),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Text(
                      options[1],
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),

            //ARALIK
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
            ),
            //ÜÇÜNCÜ BÖLME
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddWord2Ful(
                              title: 'ALAL',
                              storage: WordStorage(),
                            )),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Text(
                      options[2],
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: draweritems,
      ),
    );
  }
}
