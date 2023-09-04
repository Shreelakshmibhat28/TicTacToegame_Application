import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      title: 'Lets play TicTacToe😃',
      home: const TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _GameState();
}

class _GameState extends State<TicTacToe> {
  List<List<String>> playBoard = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  String player = 'X';
  String result = '';

  // This function is called when a player taps on a box
  void play(int row, int column) {
    if (playBoard[row][column] == '') {
      setState(() {
        playBoard[row][column] = player;
        checkWinner();
        if (result == '') {
          player = player == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  // This function is called after every move and says if there is a winner
  void checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (playBoard[i][0] == playBoard[i][1] &&
          playBoard[i][1] == playBoard[i][2] &&
          playBoard[i][0] != '') {
        result = '${playBoard[i][0]} wins🤩';
        return;
      }
      if (playBoard[0][i] == playBoard[1][i] &&
          playBoard[1][i] == playBoard[2][i] &&
          playBoard[0][i] != '') {
        result = '${playBoard[0][i]} wins🤩';
        return;
      }
    }
    if (playBoard[0][0] == playBoard[1][1] &&
        playBoard[1][1] == playBoard[2][2] &&
        playBoard[0][0] != '') {
      result = '${playBoard[0][0]} wins🤩';
      return;
    }
    if (playBoard[0][2] == playBoard[1][1] &&
        playBoard[1][1] == playBoard[2][0] &&
        playBoard[0][2] != '') {
      result = '${playBoard[0][2]} wins🤩';
      return;
    }
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (playBoard[i][j] == '') {
          return;
        }
      }
    }
    result = 'Draw😯';
  }

  // This function is called when you click on PLAY AGAIN button
  void playAgain() {
    setState(() {
      playBoard = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ];
      player = 'X';
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe😉'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () => play(row, col),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      color: playBoard[row][col] == 'X'
                          ? Colors.amberAccent
                          : playBoard[row][col] == 'O'
                          ? Colors.deepOrange
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        playBoard[row][col],
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Display the current player
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Player $player turn',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          // Display the result
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: result == '' ? Colors.transparent : Colors.pink.shade800,
              ),
            ),
          ),

          // Play Again button
          Container(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: playAgain,
              child: const Text(
                'Play Again',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}