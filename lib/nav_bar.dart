import 'package:archivist/pages/home.dart';
import 'package:archivist/pages/search.dart';
import 'package:archivist/pages/settings.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'db/use_database.dart';

class NavBar {
  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              tooltip: "Navigation Menu",
              onPressed: () {
                //print("nav button pressed");
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ));
  }

  // Drawer buttons defined here
  Drawer buildDrawer(BuildContext context) {
    var navBarItems = [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: Text(
          "Archivist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Home'),
        onTap: () {
          //Navigator.pop(context); Not sure if this is doing anything important
          Navigator.of(context).push(PageTransition(
                  child: const HomePage(),
                  type: PageTransitionType
                      .fade) // not the biggest fan of this animation but it's okay enough
              );
        },
      ),
      ListTile(
        leading: const Icon(Icons.search),
        title: const Text('Search'),
        onTap: () {
          Navigator.of(context).push(PageTransition(
              child: const SearchPage(), type: PageTransitionType.fade));
        },
      ),
      ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            //Navigator.pop(context);
            Navigator.of(context).push(PageTransition(
                child: const SettingsPage(), type: PageTransitionType.fade));
          }),
    ];

    // Items to only show up in debug mode
    if (foundation.kDebugMode) {
      var debugOptions = [
        ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Clear Database'),
            onTap: () {
              db.deleteAll();
            }),
        ListTile(
            leading: const Icon(Icons.list),
            title: const Text('List Database in Console'),
            onTap: () {
              db.list();
            }),
      ];

      navBarItems.addAll(debugOptions);
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: navBarItems,
      ),
    );
  }
}
