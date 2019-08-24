import 'meme.dart';
import 'package:flutter/material.dart';

void main() {
  ThemeData theme;
  theme = ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.redAccent,
      toggleableActiveColor: Colors.red,
    );
  runApp(
    new MemeCreator(
      theme: theme,
    ),
  );
}
