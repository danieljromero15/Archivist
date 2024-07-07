import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'nav_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.title = 'Settings'});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar().buildAppBar(context, widget.title),
      drawer: NavBar().buildDrawer(context),
      body: SettingsList(
        applicationType: ApplicationType.material,
        sections: [
          SettingsSection(
              title: const Text('Section 1'),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  value: const Text('English'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: const Icon(Icons.format_paint),
                  title: const Text('Enable custom theme'),
                ),
                SettingsTile(
                  title: const Text('I have no idea what I\'m doing'),
                )
              ]
          )
        ],
      )
    );
  }
}