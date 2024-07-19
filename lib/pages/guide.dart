import 'package:archivist/nav_bar.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key, this.title = 'API Keys Guide'});

  final String title;

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: NavBar().buildAppBar(context, widget.title), // TODO change button in navdrawer to go back to settings instead of drawer
      drawer: NavBar().buildDrawer(context),
      body: const Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            //TODO Add images and clean up the text to make it more presentable.
            Text(
                'This is a quick guide to help you set up your API keys to use Archivist.'),
            SizedBox(
              height: 50,
            ),
            Text(
                'As of right now, we haven\'t found a way to properly implement a user account system, so for now, you\'ll have to add your own API keys.'),
            Text(
                'Fortunately, all you need is a Twitch account with 2FA enabled.'),
            Text('STEP 1: SET UP YOUR API KEYS'),
            Text('First, go to dev.twitch.tv and sign into your account.'),
            Text('Second, click the Go To Console button on the top right.'),
            Text('Third, select applications on the left side of the menu'),
            Text('Fourth, select Register your Application'),
            Text(
                'Finally, set your settings as follows.  Have the name be any name you want, but it has to be unique.  Set your OAuth field to localhost with a random port.  My recommendation is \'https://localhost:8080\''),
            Text('STEP 2: IMPORT YOUR API KEYS INTO ARCHIVIST'),
            Text(
                'Once you\'ve created your application, you can now grab your API keys.'),
            Text(
                'On your newly created application, select Manage, and at the bottom you\'ll need two strings of text for your API keys.'),
            Text(
                'First is your Client ID.  This is considered your API key in Archivist.  Copy it and paste it into the API Key field in Settings.'),
            Text(
                'Next is your Client Secret.  This is considered your Secret Key in Archvist.  Click the New Secret button, and copy-paste the newly added text below the button into the Secret Key field in Settings.'),
            Text(
                'Once you\'ve finished both tasks, you are done!  You can now use Archivist freely!  Eventually we\'ll get around to adding Twitch integration, but at a later date XD'),
          ],
        ),
      ),
    );
  }
}
