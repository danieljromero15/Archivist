import 'package:archivist/pages/guide.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:archivist/main.dart';

import '../nav_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.title = 'Settings'});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String testButtonSubtitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar().buildAppBar(context, widget.title),
        drawer: NavBar().buildDrawer(context),
        body: SettingsContainer(
          children: [
            SettingsGroup(title: "API Settings", children: [
              SimpleSettingsTile(
                title: "Setup",
                showDivider: true,
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      child: const GuidePage(), type: PageTransitionType.fade));
                },
              ),
              TextInputSettingsTile(
                title: "IGDB API Key",
                settingKey: "APIKey",
                validator: (String? key) {
                  if (key != null && key.isNotEmpty) {
                    return null;
                  }
                  return "API Key can't be empty";
                },
              ),
              TextInputSettingsTile(
                title: "IGDB API Secret",
                settingKey: "APISecret",
                validator: (String? key) {
                  if (key != null && key.isNotEmpty) {
                    return null;
                  }
                  return "API Key can't be empty";
                },
                obscureText: true,
              ),
              SimpleSettingsTile(
                title: "Test API access",
                showDivider: false,
                subtitle: testButtonSubtitle,
                onTap: () async {
                  bool results = await gamesApi!.test();
                  if (results) {
                    testButtonSubtitle = "Test Passed!";
                  } else {
                    testButtonSubtitle = "Test Failed, please try again.";
                  }
                  setState(() {});
                },
              ),
            ]),
          ],
        ));
  }
}
