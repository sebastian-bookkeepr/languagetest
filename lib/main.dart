import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/widgets/styled_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'GB'), Locale('de', 'DE')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('de', 'DE'),
      //assetLoader: HttpAssetLoader().load("", Locale('en', 'GB')),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _gender = "male";
  final List<String> _genders = ['male', 'female', 'other'];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(
                onPressed: () {
                  if (context.locale == const Locale('en', 'GB')) {
                    context.setLocale(const Locale('de', 'DE'));
                  } else {
                    context.setLocale(const Locale('en', 'GB'));
                  }
                },
                child: const Text("Change translation"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Simple Translation: "),
                  const Text("helloworld").tr(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Translation with count: "),
                  const Text("revenues").plural(_counter),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Translation with placeholder: "),
                  const Text("openItem")
                      .tr(namedArgs: {"item": "revenues".plural(_counter)}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Translation with gender: "),
                  const Text("createNew").tr(
                      gender: _gender,
                      namedArgs: {"item": "revenues".plural(_counter)}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Translation with bold Text: "),
                  StyledText(
                    text: "openRecordsSublineText"
                        .tr(args: [_counter.toString()]),
                    tags: {
                      'bold': StyledTextTag(
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Translation with linked Translation: "),
                  Expanded(
                    child: const Text("deleteImage")
                        .tr(namedArgs: {"count": _counter.toString()}),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                onPressed: _decrementCounter,
                icon: const Icon(Icons.remove),
              ),
              IconButton(
                onPressed: _incrementCounter,
                icon: const Icon(Icons.add),
              ),
              ToggleSwitch(
                initialLabelIndex: _genders.indexOf(_gender),
                activeBgColor: const [Colors.green],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.grey[900],
                totalSwitches: 3,
                labels: _genders,
                onToggle: (index) {
                  setState(() {
                    if (index != null) _gender = _genders[index];
                  });
                },
              ),
            ],
          ),
        ));
  }
}
