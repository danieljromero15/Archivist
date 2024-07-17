

import 'package:archivist/pages/description.dart';
import 'package:archivist/pages/home.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../nav_bar.dart';

List<String> planningGames = [];
List<String> playingGames = [];
List<String> completedGames = [];
List<String> oneHundredGames = [];
void onStatusSelected(int num){
  switch(num){
    case 0:
      // code
    //planningGames.add();
      break;
    case 1:
      //code
    //playingGames.add();
      break;
    case 2:
      //code
    //completedGames.add();
      break;
    case 3:
      //code
    //oneHundredGames.add();
      break;
    default: return null;
  }
}

