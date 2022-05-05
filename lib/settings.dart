import 'package:deneme1/themes/config.dart';
import 'package:deneme1/themes/theme_colors.dart';
import 'package:flutter/material.dart';
import 'neumorphism_button.dart';

void main() {
  runApp(
    const SettingsPageFul(),
  );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ALAL',
      home: SettingsPageFul(),
    );
  }
}

class SettingsPageFul extends StatefulWidget {
  const SettingsPageFul({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsPageFulState createState() => _SettingsPageFulState();
}

class _SettingsPageFulState extends State<SettingsPageFul> {
  var checkSizes = [0.0, 0.0];
  var button1 = const NeumorphismButton(
    height: 50,
    width: 50,
    color: CustomColors.terraCota,
  );

  @override void initState() {
    checkSizes[currentTheme.currentThemeIndexData]=30.0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Pick The Theme:'),
              const SizedBox(
                height: 50,
                width: 50,
              ),
              GestureDetector(
                onTap: () {
                  currentTheme.chooseTheme(0);
                  checkSizes = [30.0, 0.0];
                  setState(() {});
                },
                child: Container(
                  color: CustomColors.terraCota,
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.check_rounded,
                    size: checkSizes[0],
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
                width: 50,
              ),
              GestureDetector(
                onTap: () {
                  currentTheme.chooseTheme(1);
                  checkSizes = [0.0, 30.0];
                  setState(() {});
                },
                child: Container(
                  color: CustomColors.bouquet,
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.check_rounded,
                    size: checkSizes[1],
                    color: Colors.blue,
                  ),
                ),
              ),
              NeumorphismButton(
                height: 50,
                width: 50,
                color: CustomColors.terraCota,
                onTap: () {
                  currentTheme.chooseTheme(0);
                  checkSizes = [30.0, 0.0];
                  setState(() {});
                },
              ),
              NeumorphismButton(
                height: 50,
                width: 50,
                color: CustomColors.bouquet,
                onTap: () {
                  currentTheme.chooseTheme(1);
                  checkSizes = [0.0, 30.0];
                  setState(() {});
                },
              ),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 30,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Profile Settings',
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.format_paint_rounded,
                          size: 30,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Theme',
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.format_paint_rounded,
                            size: 30,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
