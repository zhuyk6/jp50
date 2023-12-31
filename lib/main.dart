import 'dart:math';
import 'package:flutter/material.dart';

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
      home: const Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  Widget selectPage() {
    switch (currentPageIndex) {
      case 0:
        return const TestOptionPage();
      // case 1:
      //   return LearnPage();
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.quiz),
            label: "Test",
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: "Learn",
          ),
        ],
      ),
      body: selectPage(),
    );
  }
}

class TestOptionPage extends StatefulWidget {
  const TestOptionPage({super.key});

  @override
  State<TestOptionPage> createState() => _TestOptionPageState();
}

class _TestOptionPageState extends State<TestOptionPage> {
  double _number = 10;
  (bool, bool) _option = (true, false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Number of tests: ${_number.round()}"),
          Slider(
            value: _number,
            min: 10,
            max: 50,
            divisions: 4,
            label: _number.round().toString(),
            onChanged: (double value) {
              setState(() {
                _number = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownMenu(
            label: const Text("Type"),
            onSelected: (selected) {
              setState(() {
                if (selected != null) {
                  _option = selected;
                }
              });
            },
            // initialSelection: (true, false),
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: (true, false),
                label: "平假名 Hiragana",
              ),
              DropdownMenuEntry(
                value: (false, true),
                label: "片假名 Katakana",
              ),
              DropdownMenuEntry(
                value: (true, true),
                label: "都测试 Both",
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TestPage(
                        option: _option,
                        testNumber: _number.round(),
                      )));
            },
            child: const Text("Go!"),
          ),
        ],
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   static const routeName = "/home";

//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     void _chooseTestOptionDialog() async {
//       (bool, bool) option = await showDialog(
//         context: context,
//         builder: (BuildContext context) => SimpleDialog(
//           title: const Text("Choose test:"),
//           children: [
//             const Divider(),
//             SimpleDialogOption(
//               child: const Text("Hiragana"),
//               onPressed: () {
//                 Navigator.pop(context, (true, false));
//               },
//             ),
//             const Divider(),
//             SimpleDialogOption(
//               child: const Text("Katakana"),
//               onPressed: () {
//                 Navigator.pop(context, (false, true));
//               },
//             ),
//             const Divider(),
//             SimpleDialogOption(
//               child: const Text("Both"),
//               onPressed: () {
//                 Navigator.pop(context, (true, true));
//               },
//             ),
//           ],
//         ),
//       );

//       var inputController = TextEditingController(text: "10");
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Number of tests:"),
//           content: TextField(
//             controller: inputController,
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(int.parse(inputController.text));
//               },
//               child: const Text('OK'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//           ],
//         ),
//       ).then((value) {
//         if (value != null) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => TestPage(
//                         option: option,
//                         testNumber: value,
//                       )));
//         }
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text("Home"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => (),
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//               child: Text(
//                 "Learn",
//                 style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//               ),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             ElevatedButton(
//               onPressed: _chooseTestOptionDialog,
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//               child: Text(
//                 "Test",
//                 style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

enum TestPageIndex {
  query,
  help,
  guess,
  finish;
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

  TestPageIndex pageIndex = TestPageIndex.query;

  int _currentNumber = 0;
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

      pageIndex = TestPageIndex.query;
      _currentNumber++;
      if (_currentNumber > widget.testNumber) {
        pageIndex = TestPageIndex.finish;
      }
    });
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
        content: Text("$_character is $_rome."),
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
        if (guess == _rome) {
          _correctNumber++;
        }
      });

      Widget dialog = guess == _rome ? correctDialog : wrongDialog;

      showDialog(
        context: context,
        builder: (context) => dialog,
      );
    }

    return f;
  }

  Widget _selectPage() {
    switch (pageIndex) {
      case TestPageIndex.query:
        return TestQuery(
          character: _character,
          onClickHelp: () {
            setState(() {
              pageIndex = TestPageIndex.help;
            });
          },
          onClickTry: () {
            setState(() {
              pageIndex = TestPageIndex.guess;
            });
          },
        );
      case TestPageIndex.help:
        return TestHelp(
          character: _character,
          rome: _rome,
          onClickNext: () {
            _getNext();
          },
        );
      case TestPageIndex.guess:
        return TestTry(
          character: _character,
          onClick: _checkAnswer,
        );
      case TestPageIndex.finish:
        return TestFinish(
          total: widget.testNumber,
          correct: _correctNumber,
        );
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _selectPage();
  }
}

class TestQuery extends StatelessWidget {
  const TestQuery({
    super.key,
    required this.character,
    required this.onClickHelp,
    required this.onClickTry,
  });

  final String character;
  final void Function() onClickHelp;
  final void Function() onClickTry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Query"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                character,
                style: TextStyle(
                  fontSize: 150,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onClickHelp,
                  icon: const Icon(Icons.question_mark),
                  label: const Text("Help"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  onPressed: onClickTry,
                  icon: const Icon(Icons.done),
                  label: const Text("Try"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TestHelp extends StatelessWidget {
  const TestHelp(
      {super.key,
      required this.character,
      required this.rome,
      required this.onClickNext});

  final String character;
  final String rome;
  final void Function() onClickNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              character,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            Text(
              rome,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            ElevatedButton(
              onPressed: onClickNext,
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}

class TestTry extends StatelessWidget {
  const TestTry({super.key, required this.character, required this.onClick});

  final String character;
  final void Function() Function(int) onClick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guess $character"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.count(
        crossAxisCount: 5,
        padding: const EdgeInsets.all(5),
        mainAxisSpacing: 2,
        children: List.generate(
          50,
          (index) => ElevatedButton(
            onPressed: onClick(index),
            style: ElevatedButton.styleFrom(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(JanpaneseCharacters.romes[index ~/ 5][index % 5]),
          ),
        ),
      ),
    );
  }
}

class TestFinish extends StatelessWidget {
  const TestFinish({
    super.key,
    required this.total,
    required this.correct,
  });

  final int total;
  final int correct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finished"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.celebration,
              size: 50,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                "You guess ${correct.toString()} of ${total.toString()} correctly."),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
