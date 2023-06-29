import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context);

    final titleStyle = theme.textTheme.displayMedium!.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    );

    final buttonText = theme.textTheme.displayMedium!.copyWith(
      fontSize: 15,
      color: theme.colorScheme.primary,
    );

    return Scaffold(
      body: Column(
        children: [
          Center(
            heightFactor: 5,
            child: Column(
              children: [
                Text(
                  'Click the button to get new words!',
                  style: titleStyle,
                ),
                BigCard(pair: pair),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Next',
                      style: buttonText,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 20,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: textStyle,
        ),
      ),
    );
  }
}
