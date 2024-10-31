import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  final translator = GoogleTranslator();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  String lbl1 = "";
  String lbl2 = "";

  @override
  void dispose() {
    // TODO: implement dispose
    fromController.dispose();
    toController.dispose();

    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
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
            TextField(
              controller: fromController,
            ),
            Text(lbl1),
            Divider(),
            TextField(
              controller: toController,
            ),
            Text(lbl2),
            ElevatedButton(
                onPressed: () async {
                  await translator.getSpeech(fromController.text.trim(), "my");
                },
                child: Text("Play1")),
            ElevatedButton(
                onPressed: () async {
                  await translator.getSpeech(toController.text.trim(), "th");
                },
                child: Text("Play2")),
            ElevatedButton(
                onPressed: () async {
                  final val = await translator.translate(
                      fromController.text.trim(),
                      from: "my",
                      to: "th");
                  toController.text = val.text;

                  final txt1 = await translator.getPhoneticTranscription(
                      fromController.text.trim(), 'my');

                  print(txt1);
                  final txt2 = await translator.getPhoneticTranscription(
                      toController.text.trim(), 'th');

                  print(txt2);
                  setState(() {
                    lbl1 = txt1;
                    lbl2 = txt2;
                  });
                },
                child: Text("Translate"))
          ],
        ),
      ),
    );
  }
}
