import 'package:archivist/nav_bar.dart';
import 'package:archivist/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: "Back to settings",
                onPressed: () {
                  Navigator.of(context).push(PageTransition(
                      child: const SettingsPage(),
                      type: PageTransitionType.fade));
                });
          },
        ),
      ),
      body: const Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 1600,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                //TODO Add images and clean up the text to make it more presentable.
                Text(
                  style: TextStyle(
                    fontSize: 24.0
                  ),
                    'This is a quick guide to help you set up your API keys to use Archivist.'),
                SizedBox(
                  height: 50,
                ),
                Text(
                    'As of right now, we haven\'t found a way to properly implement a user account system, so for now, you\'ll have to add your own API keys.'),
                Text(
                    'Fortunately, all you need is a Twitch account with 2FA enabled.'),
                SizedBox(height: 50,),
                Text(
                    style: TextStyle(
                        fontSize: 24.0
                    ),
                    'STEP 1: SET UP YOUR API KEYS'),
                Text('First, go to dev.twitch.tv and sign into your account.'),
                SizedBox(height: 25,),
                Text('Second, click the Go To Console button on the top right.'),
                SizedBox(height: 25,),
                Image(
                  height: 500,
                  image: AssetImage('assets/Screenshot_1.png'), ),
                SizedBox(height: 25,),
                Text('Third, select applications on the left side of the menu'),
                SizedBox(height: 25,),
                Image(
                    height: 500,
                    image: AssetImage('assets/Screenshot_2.png')),
                SizedBox(height: 25,),
                Text('Fourth, select Register your Application'),
                SizedBox(height: 25,),
                Image(
                    height: 500,
                    image: AssetImage('assets/Screenshot_3.png')),
                SizedBox(height: 25,),
                Text(
                    'Finally, set your settings as follows.  Have the name be any name you want, but it has to be unique.  '
                        'Set your OAuth field to localhost with a random port.  My recommendation is \'https://localhost:8080\''
                        'Set your Category to Application Implementation, and set your client type to Confidential.'),
                SizedBox(height: 25,),
                Image(
                    height: 500,
                    image: AssetImage('assets/Screenshot_4.png')),
                SizedBox(height: 50,),
                Text(
                    style: TextStyle(
                        fontSize: 24.0
                    ),
                    'STEP 2: IMPORT YOUR API KEYS INTO ARCHIVIST'),
                Text(
                    'Once you\'ve created your application, you can now grab your API keys.'),
                SizedBox(height: 25,),
                Image(
                    height: 500,
                    image: AssetImage('assets/Screenshot_8.png')),
                Text(
                    'On your newly created application, select Manage, and at the bottom you\'ll need two strings of text for your API keys.'),
                SizedBox(height: 25,),
                Image(
                    height: 500,
                    image: AssetImage('assets/Screenshot_5.png')),
                SizedBox(height: 25,),
                Text(
                    'First is your Client ID.  This is considered your API key in Archivist.  Copy it and paste it into the API Key field in Settings.'),
                SizedBox(height: 25,),
                Image(image: AssetImage('assets/Screenshot_6.png')),
                SizedBox(height: 25,),
                Text(
                    'Next is your Client Secret.  This is considered your Secret Key in Archvist.  Click the New Secret button, and copy-paste the newly added text below the button into the Secret Key field in Settings.'),
                SizedBox(height: 25,),
                Image(
                    height: 500,
                    image: AssetImage('assets/Screenshot_7.png')),
                SizedBox(height: 25,),
                Text(
                    'Once you\'ve finished both tasks, you are done!  Make sure to test if your keys work by using the Test API button in the settings page.  If the text \'Test Passed\' shows up, you are ready to use Archivist!'),
                SizedBox(height: 25,),
                Image(
                    height: 500,
                    image: AssetImage('assets/Screenshot_9.png')),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
