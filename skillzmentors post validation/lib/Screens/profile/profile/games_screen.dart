import 'package:flutter/material.dart';
import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  late List<String> _board;
  late String _currentPlayer;
  late String _winner;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _board = List<String>.filled(9, '');
      _currentPlayer = 'X';
      _winner = '';
    });
  }

  void _handleTap(int index) {
    if (_board[index] == '' && _winner == '') {
      setState(() {
        _board[index] = _currentPlayer;
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        _winner = _checkWinner();
      });
    }
  }

  String _checkWinner() {
    const List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (_board[combination[0]] != '' &&
          _board[combination[0]] == _board[combination[1]] &&
          _board[combination[1]] == _board[combination[2]]) {
        return _board[combination[0]];
      }
    }

    if (!_board.contains('')) {
      return 'Draw';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButton(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        const  Center(
            child: Text(
              'Tic Tac Toe',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
         const SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                color: Colors.blue[300],
              ),
              width: 300,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildBoard(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildStatus(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Reset Game'),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _handleTap(index),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                _board[index],
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatus() {
    String status;
    if (_winner == '') {
      status = 'Current Player: $_currentPlayer';
    } else if (_winner == 'Draw') {
      status = 'Game Draw!';
    } else {
      status = 'Winner: $_winner';
    }

    return Text(
      status,
      style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontFamily: 'TimesNewRoman'),
    );
  }
}
