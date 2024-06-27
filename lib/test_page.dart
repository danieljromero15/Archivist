import 'package:flutter/material.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      //home: const NavigationDrawerExample(),
    );
    /*Scaffold(
      appBar: AppBar(
        title: const Text("TEST"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("TESTAAAA"),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      )
    );*/
  }
}

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
      'Messages', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  ExampleDestination(
      'Profile', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  ExampleDestination(
      'Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
];