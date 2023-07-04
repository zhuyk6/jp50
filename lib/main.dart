import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  static const routeName = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void _chooseTestOptionDialog() async {
      (bool, bool) option = await showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          title: const Text("Choose test:"),
          children: [
            const Divider(),
            SimpleDialogOption(
              child: const Text("Hiragana"),
              onPressed: () {
                Navigator.pop(context, (true, false));
              },
            ),
            const Divider(),
            SimpleDialogOption(
              child: const Text("Katakana"),
              onPressed: () {
                Navigator.pop(context, (false, true));
              },
            ),
            const Divider(),
            SimpleDialogOption(
              child: const Text("Both"),
              onPressed: () {
                Navigator.pop(context, (true, true));
              },
            ),
          ],
        ),
      );

      var inputController = TextEditingController(text: "10");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Number of tests:"),
          content: TextField(
            controller: inputController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(int.parse(inputController.text));
              },
              child: const Text('OK'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ).then((value) {
        if (value != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TestPage(
                        option: option,
                        testNumber: value,
                      )));
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => (),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Learn",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _chooseTestOptionDialog,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Test",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JanpaneseCharacters {
  static const List<List<String>> _characters = [
    ['あ', 'ア', 'a'],
    ['い', 'イ', 'i'],
    ['う', 'ウ', 'u'],
    ['え', 'エ', 'e'],
    ['お', 'オ', 'o'],
    ['か', 'カ', 'ka'],
    ['き', 'キ', 'ki'],
    ['く', 'ク', 'ku'],
    ['け', 'ケ', 'ke'],
    ['こ', 'コ', 'ko'],
    ['さ', 'サ', 'sa'],
    ['し', 'シ', 'shi'],
    ['す', 'ス', 'su'],
    ['せ', 'セ', 'se'],
    ['そ', 'ソ', 'so'],
    ['た', 'タ', 'ta'],
    ['ち', 'チ', 'chi'],
    ['つ', 'ツ', 'tsu'],
    ['て', 'テ', 'te'],
    ['と', 'ト', 'to'],
    ['な', 'ナ', 'na'],
    ['に', 'ニ', 'ni'],
    ['ぬ', 'ヌ', 'nu'],
    ['ね', 'ネ', 'ne'],
    ['の', 'ノ', 'no'],
    ['は', 'ハ', 'ha'],
    ['ひ', 'ヒ', 'hi'],
    ['ふ', 'フ', 'fu'],
    ['へ', 'ヘ', 'he'],
    ['ほ', 'ホ', 'ho'],
    ['ま', 'マ', 'ma'],
    ['み', 'ミ', 'mi'],
    ['む', 'ム', 'mu'],
    ['め', 'メ', 'me'],
    ['も', 'モ', 'mo'],
    ['や', 'ヤ', 'ya'],
    ['ゆ', 'ユ', 'yu'],
    ['よ', 'ヨ', 'yo'],
    ['ら', 'ラ', 'ra'],
    ['り', 'リ', 'ri'],
    ['る', 'ル', 'ru'],
    ['れ', 'レ', 're'],
    ['ろ', 'ロ', 'ro'],
    ['わ', 'ワ', 'wa'],
    ['を', 'ヲ', 'wo'],
  ];

  static List<String> randomSelect() {
    var index = Random().nextInt(_characters.length);
    return _characters[index];
  }

  static List<List<String>> get romes => [
        ['a', 'i', 'u', 'e', 'o'],
        ['ka', 'ki', 'ku', 'ke', 'ko'],
        ['sa', 'shi', 'su', 'se', 'so'],
        ['ta', 'chi', 'tsu', 'te', 'to'],
        ['na', 'ni', 'nu', 'ne', 'no'],
        ['ha', 'hi', 'fu', 'he', 'ho'],
        ['ma', 'mi', 'mu', 'me', 'mo'],
        ['ya', '', 'yu', '', 'yo'],
        ['ra', 'ri', 'ru', 're', 'ro'],
        ['wa', '', '', '', 'wo'],
      ];
}

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.option, required this.testNumber});

  final (bool, bool) option;
  final int testNumber;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool _select((bool, bool) option) {
    bool choose = true;
    if (option.$1 && option.$2) {
      choose = Random().nextBool();
    } else if (option.$1) {
      choose = true;
    } else if (option.$2) {
      choose = false;
    } else {
      throw Error();
    }
    return choose;
  }

  String _character = "test";
  String _rome = "test";
  bool _showRome = false;

  int _finishedNumber = 0;
  int _correctNumber = 0;

  @override
  void initState() {
    super.initState();
    _getNext();
  }

  void _getNext() {
    var pair = JanpaneseCharacters.randomSelect();
    setState(() {
      bool choose = _select(widget.option);
      _character = choose ? pair[0] : pair[1];
      _rome = pair[2];
      _showRome = false;
    });
  }

  void _toggleShowRome() {

    setState(() {
      _showRome = !_showRome;
    });
    print("toggle ! $_showRome");
  }

  void Function() _checkAnswer(int index) {
    void f() {
      final r = index ~/ 5;
      final c = index % 5;
      final guess = JanpaneseCharacters.romes[r][c];

      Widget correctDialog = AlertDialog(
        title: const Text(
          "Correct!",
          style: TextStyle(color: Colors.green),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _getNext();
            },
            child: const Text("Next"),
          ),
        ],
      );

      Widget wrongDialog = AlertDialog(
        title: const Text(
          "Wrong!",
          style: TextStyle(color: Colors.red),
        ),
        content: Text("The correct answer is $_rome."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _getNext();
            },
            child: const Text("Next"),
          )
        ],
      );

      setState(() {
        _finishedNumber++;
        if (guess == _rome) {
          _correctNumber++;
        }
      });

      Widget dialog = guess == _rome ? correctDialog : wrongDialog;

      showDialog(
        context: context,
        builder: (context) => dialog,
      );

      if (_finishedNumber >= widget.testNumber) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Result"),
            content: Text("Correct $_correctNumber in $_finishedNumber."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popUntil(
                      context,
                      ModalRoute.withName(
                          "/home")); // close result dialog// close test page
                },
                child: const Text("Close"),
              ),
            ],
          ),
        );
      }
    }

    return f;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleShowRome,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  !_showRome ? _character : _rome,
                  style: const TextStyle(
                    fontSize: 150,
                  ),
                ),
              ),
              const Divider(),
              GridView.count(
                crossAxisCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  50,
                  (index) => ElevatedButton(
                    onPressed: _checkAnswer(index),
                    child:
                        Text(JanpaneseCharacters.romes[index ~/ 5][index % 5]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
