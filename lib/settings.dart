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
    var button1 =              const NeumorphismButton(
                height: 50,
                width: 50,
                color: CustomColors.terraCota,

              );
  @override
  Widget build(BuildContext context) {
    final settingsList = <_SettingsInfo>[
      const _SettingsInfo(
        Icons.person,
        '',
      ),
      const _SettingsInfo(
        Icons.notifications,
        '',
      ),
      const _SettingsInfo(
        Icons.security,
        '',
      ),
      const _SettingsInfo(
        Icons.help,
        '',
      ),
    ];

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
            shrinkWrap: true,
            children: [
              for (var setting in settingsList) _SettingsTile(setting),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile(this.settingData);
  final _SettingsInfo settingData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(settingData.settingIcon),
          title: Text(settingData.settingsLabel),
        ),
        const Divider(thickness: 2),
      ],
    );
  }
}

class _SettingsInfo {
  const _SettingsInfo(this.settingIcon, this.settingsLabel);

  final IconData settingIcon;
  final String settingsLabel;
}
