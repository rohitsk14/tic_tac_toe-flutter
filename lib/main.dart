import 'package:flutter/material.dart';
import 'package:tictactoe/game_button.dart';

void main() => runApp(MyApp());

Color primaryColor = Colors.orangeAccent;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GameButton> theList;
  int activePlayer = 1;
  var playerOne = List();
  var playerTwo = List();
  bool gameOver = false;
  double sliderValue = 2;
  String winner = '';
  int cnt = 0;

  bool mute = false;

  void togglePlayer() {
    if (activePlayer == 1) {
      activePlayer = 2;
    } else {
      activePlayer = 1;
    }
  }

  void play(GameButton button) {
    setState(() {
      if (activePlayer == 1) {
        button.title = 'O';
        button.bgColor = Colors.blueAccent;
        playerOne.add(button.id);
        togglePlayer();
      } else {
        button.title = 'X';
        button.bgColor = Colors.green;
        playerTwo.add(button.id);
        togglePlayer();
      }
      button.enabled = false;
      cnt++;
      checkForWinner();
    });
  }

  void checkForWinner() {
    //horizontal
    if (playerOne.contains(1) &&
        playerOne.contains(2) &&
        playerOne.contains(3)) {
      winner = 'Player One';
    }
    if (playerOne.contains(4) &&
        playerOne.contains(5) &&
        playerOne.contains(6)) {
      winner = 'Player One';
    }
    if (playerOne.contains(7) &&
        playerOne.contains(8) &&
        playerOne.contains(9)) {
      winner = 'Player One';
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(2) &&
        playerTwo.contains(3)) {
      winner = 'Player Two';
    }
    if (playerTwo.contains(4) &&
        playerTwo.contains(5) &&
        playerTwo.contains(6)) {
      winner = 'Player Two';
    }
    if (playerTwo.contains(7) &&
        playerTwo.contains(8) &&
        playerTwo.contains(9)) {
      winner = 'Player Two';
    }
//    verticle
    if (playerOne.contains(1) &&
        playerOne.contains(4) &&
        playerOne.contains(7)) {
      winner = 'Player One';
    }
    if (playerOne.contains(2) &&
        playerOne.contains(5) &&
        playerOne.contains(8)) {
      winner = 'Player One';
    }
    if (playerOne.contains(3) &&
        playerOne.contains(6) &&
        playerOne.contains(9)) {
      winner = 'Player One';
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(4) &&
        playerTwo.contains(7)) {
      winner = 'Player Two';
    }
    if (playerTwo.contains(2) &&
        playerTwo.contains(5) &&
        playerTwo.contains(8)) {
      winner = 'Player Two';
    }
    if (playerTwo.contains(3) &&
        playerTwo.contains(6) &&
        playerTwo.contains(9)) {
      winner = 'Player Two';
    }
//      diagonal
    if (playerOne.contains(1) &&
        playerOne.contains(5) &&
        playerOne.contains(9)) {
      winner = 'Player One';
    }
    if (playerOne.contains(3) &&
        playerOne.contains(5) &&
        playerOne.contains(7)) {
      winner = 'Player One';
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(5) &&
        playerTwo.contains(9)) {
      winner = 'Player Two';
    }
    if (playerTwo.contains(3) &&
        playerTwo.contains(5) &&
        playerTwo.contains(7)) {
      winner = 'Player Two';
    }
    if (winner.length > 2) {
      for (int i = 0; i < 9; i++) {
        theList[i].enabled = false;
      }
    }
  }

  void refresh() {
    setState(() {
      cnt = 0;
      winner = '';
      for (int i = 0; i < 9; i++) {
        theList[i].title = '';
        theList[i].bgColor = primaryColor;
        theList[i].enabled = true;
      }
      playerOne.clear();
      playerTwo.clear();
    });
  }

  @override
  void initState() {
    theList = List<GameButton>.generate(
        9, (i) => GameButton(id: i + 1, bgColor: primaryColor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0),
              itemCount: theList.length,
              itemBuilder: (context, i) => SizedBox(
                height: 100.0,
                width: 100.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(8.0),
                  onPressed: theList[i].enabled ? () => play(theList[i]) : null,
                  child: Text(
                    theList[i].title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                  color: theList[i].bgColor,
                  disabledColor: theList[i].bgColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: winner.length < 2
                ? Text(
                    cnt != 9 ? "Player $activePlayer's turn " : "It's a Draw",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : null,
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: winner.length > 2
                ? Text(
                    "$winner is The Winner!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refresh,
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: primaryColor,
        child: Container(
            margin: EdgeInsets.all(10.0),
            height: 60.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Change Theme',
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    value: sliderValue,
                    onChanged: (double value) {
                      setState(() {
                        sliderValue = value;
                        if (sliderValue == 1.0) {
                          primaryColor = Colors.lime[400];
                        }
                        if (sliderValue == 2.0) {
                          primaryColor = Colors.orangeAccent;
                        }
                        if (sliderValue == 3.0) {
                          primaryColor = Colors.redAccent;
                        }
                        for (int i = 0; i < 9; i++) {
                          if (theList[i].title == '') {
                            theList[i].bgColor = primaryColor;
                          }
                        }
                      });
                    },
                    min: 1,
                    max: 3,
                    divisions: 2,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
