import 'package:flutter/material.dart';



final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  secondaryHeaderColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[200],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  secondaryHeaderColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.grey[900],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  ),
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Toggle Demo',
      debugShowCheckedModeBanner: false,
      theme: isDark ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Theme Toggle Page'),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
            child: Text(isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode'),
          ),
        ),
      ),
    );
  }
}