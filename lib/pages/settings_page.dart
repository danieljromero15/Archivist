import 'package:archivist/api/api_keys.dart';
import 'package:archivist/pages/description.dart';
import 'package:archivist/pages/guide.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:settings_ui/settings_ui.dart';

import '../nav_bar.dart';

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
            SettingsSection(title: const Text('Section 1'), tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.key),
                title: const Text('IGDB API Key'),
                value: const Text(igdbApiKey),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.lock),
                title: const Text('IGDB API Secret'),
                value: const Text(igdbApiSecret),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.format_paint),
                title: const Text('Enable custom theme'),
                enabled: false,
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.help),
                  title: const Text('How to set up API keys'),
              value: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageTransition(
                        child: const GuidePage(),
                    type: PageTransitionType.fade));
                  },
                  child: const Text('Guide')
              ),
              ),
              SettingsTile(
                title: const Text('I have no idea what I\'m doing'),
              )
            ])
          ],
        ));
  }
}
