import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'Utils/common.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.isComputerMode = false,
    this.useCustomBoard = false,
  });

  final String title;
  final bool isComputerMode;
  final bool useCustomBoard;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color ply1Color = Colors.amberAccent;
  Color ply2Color = Colors.greenAccent;
  int randomNo = 1;
  bool toAnimate = false;
  int ply1 = 0, ply2 = 0;
  bool plyturn = true;
  bool isComputer = false;

  @override
  void initState() {
    super.initState();
    isComputer = widget.isComputerMode;
    changeBoard = widget.useCustomBoard;
    name = widget.useCustomBoard ? boardName2 : boardName1;
  }

  var name = 'assets/images/custom.png';
  var boardName1 = 'assets/images/board.png';
  var boardName2 = 'assets/images/custom.png';
  bool changeBoard = false;

  int order(int n) {
    if (n <= 10)
      return 11 - n;
    else if (n <= 30 && n > 20)
      return 31 - n + 20;
    else if (n <= 50 && n > 40)
      return 51 - n + 40;
    else if (n <= 70 && n > 60)
      return 71 - n + 60;
    else if (n <= 90 && n > 80)
      return 91 - n + 80;
    else
      return n;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitDialog(context);
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.indigo.shade50,
                Colors.white,
                Colors.indigo.shade50,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                plyturn
                    ? Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ply1Color.withOpacity(0.8),
                              ply1Color.withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: ply1Color.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.person, color: Colors.white, size: 40),
                            const SizedBox(height: 8),
                            Text(
                              isComputer ? 'Computer' : 'Player 1',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : isComputer
                    ? SizedBox(
                        // height: 100,
                        // width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Icon(Icons.person, color: ply1Color),
                            ),
                            Expanded(
                              child: Container(
                                height: 150,
                                child: toAnimate
                                    ? rive.RiveAnimation.asset(
                                        'assets/DiceRoll.flr',
                                        fit: BoxFit.contain,
                                      )
                                    : Image.asset(
                                        'assets/images/$randomNo.png',
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : player1(context),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.width > 500
                        ? 500
                        : MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width > 500
                        ? 500
                        : MediaQuery.of(context).size.width,
                    // width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            child: GridView.count(
                              crossAxisCount: 10,
                              padding: EdgeInsets.all(2),
                              // Generate 100 widgets that display their index in the List.
                              children: List.generate(100, (index) {
                                return new Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  margin: EdgeInsets.all(0),
                                  borderOnForeground: true,
                                  // key: list[index],
                                  color:
                                      ply1 == 100 - index || ply2 == 100 - index
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : (10 <= index && index <= 19) ||
                                            (30 <= index && index <= 39) ||
                                            (50 <= index && index <= 59) ||
                                            (70 <= index && index <= 79) ||
                                            (90 <= index && index <= 99)
                                      ? index.isOdd
                                            ? Color.fromRGBO(220, 200, 109, 1)
                                            : Color.fromRGBO(39, 25, 60, 1)
                                      : index.isEven
                                      ? Color.fromRGBO(220, 200, 109, 1)
                                      : Color.fromRGBO(39, 25, 60, 1),
                                  child: Text(
                                    ' ${order(100 - index)}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            alignment: Alignment.topLeft,
                            child: Image.asset(name, fit: BoxFit.cover),
                          ),
                          Container(
                            child: GridView.count(
                              crossAxisCount: 10,
                              padding: EdgeInsets.all(2),
                              // Generate 100 widgets that display their index in the List.
                              children: List.generate(100, (index) {
                                return new Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  margin: EdgeInsets.all(0),
                                  borderOnForeground: true,
                                  // key: list[index],
                                  color: Color.fromRGBO(255, 255, 255, 0.0),
                                  child: Hero(
                                    tag: ply1 == 100 - index
                                        ? 'ply1_${index}'
                                        : ply2 == 100 - index
                                        ? 'ply2_${index}'
                                        : 'None_${index}',
                                    child: ply1 == 100 - index
                                        ? ply1 == ply2
                                              ? Center(
                                                  child: Icon(
                                                    Icons.people,
                                                    color: Colors.redAccent,
                                                  ),
                                                )
                                              : Center(
                                                  child: Icon(
                                                    Icons.person,
                                                    color: ply1Color,
                                                  ),
                                                )
                                        : ply2 == 100 - index
                                        ? ply1 == ply2
                                              ? Center(
                                                  child: Icon(
                                                    Icons.people,
                                                    color: Colors.redAccent,
                                                  ),
                                                )
                                              : Center(
                                                  child: Icon(
                                                    Icons.person,
                                                    color: ply2Color,
                                                  ),
                                                )
                                        : SizedBox(),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                !plyturn
                    ? Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ply2Color.withOpacity(0.8),
                              ply2Color.withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: ply2Color.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.person, color: Colors.white, size: 40),
                            const SizedBox(height: 8),
                            Text(
                              'Player 2',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : player2(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.indigo.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        'Get 1 to start the game for a player',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Exit Icon
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Title
                      const Text(
                        'Leave Game',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Message
                      const Text(
                        'Are you sure you want to exit the Game?',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Common.Qurekaid.isNotEmpty
                    ? Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Common.Qurekaid.isNotEmpty
                      ? InkWell(
                    onTap: Common.openUrl,
                    child: Image(
                      width: MediaQuery.of(context).size.width,
                      image: const AssetImage(
                        "assets/images/bannerads.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  )
                      : SizedBox(),
                )
                    : SizedBox(),
                // Buttons
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // No Button
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pop(false); // No - don't exit
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Yes Button
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.red, Colors.redAccent],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true); // Yes - exit
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ) ??
        false; // Return false if dialog is dismissed
  }

  InkWell player2(BuildContext context) {
    return InkWell(
      onTap: () {
        var randomizer = new Random(); // can get a seed as a parameter

        // Integer between 0 and 100 (0 can be 100 not)
        setState(() {
          toAnimate = true;
          Future.delayed(Duration(seconds: 1)).whenComplete(() {
            setState(() {
              randomNo = randomizer.nextInt(6) + 1;
              print(randomNo);
              toAnimate = false;
              ply2 == 0
                  ? randomNo == 1
                        ? ply2 = order(randomNo)
                        : ply2 = 0
                  : ply2 + randomNo > 100
                  ? ply2 = ply2
                  : ply2 = order(order(ply2) + randomNo);
              Future.delayed(Duration(seconds: 1)).whenComplete(() {
                setState(() {
                  ply2 = changeBoard
                      ? snakeLadderCmd2(ply2)
                      : snakeLadderCmd(ply2);
                });
              });
              if (ply2 == 100)
                showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                    title: new Text("Snakes & Ladders"),
                    content: new Text(
                      "Player 2 WON !!!\nDo you want to Restart ?",
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text('Yes'),
                        onPressed: () {
                          setState(() {
                            ply1 = 0;
                            ply2 = 0;
                          });
                          Navigator.of(context).pop();
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           new MyHomePage()),
                          // );
                        },
                      ),
                      ElevatedButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
            });
          });
          Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
            setState(() {
              plyturn = !plyturn;
              if (isComputer) {
                toAnimate = true;
                Future.delayed(Duration(seconds: 1)).whenComplete(() {
                  setState(() {
                    randomNo = randomizer.nextInt(6) + 1;
                    print(randomNo);
                    toAnimate = false;
                    ply1 == 0
                        ? randomNo == 1
                              ? ply1 = order(randomNo)
                              : ply1 = 0
                        : ply1 + randomNo > 100
                        ? ply1 = ply1
                        : ply1 = order(order(ply1) + randomNo);
                    Future.delayed(Duration(seconds: 1)).whenComplete(() {
                      setState(() {
                        ply1 = changeBoard
                            ? snakeLadderCmd2(ply1)
                            : snakeLadderCmd(ply1);
                      });
                    });
                    if (ply1 == 100)
                      showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                          title: new Text("Snakes & Ladders"),
                          content: new Text(
                            "Computer WON !!!\nDo you want to Restart ?",
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('Yes'),
                              onPressed: () {
                                setState(() {
                                  ply1 = 0;
                                  ply2 = 0;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                  });
                  Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
                    setState(() {
                      plyturn = !plyturn;
                    });
                  });
                });
              }
            });
          });
        });
      },
      child: SizedBox(
        // height: 100,
        // width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Icon(Icons.person, color: ply2Color)),
            Expanded(
              child: Container(
                height: 150,
                child: toAnimate
                    ? Flare(animation: '1')
                    : Image.asset('assets/images/$randomNo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell player1(BuildContext context) {
    return InkWell(
      onTap: () {
        var randomizer = new Random();
        setState(() {
          toAnimate = true;
          Future.delayed(Duration(seconds: 1)).whenComplete(() {
            setState(() {
              randomNo = randomizer.nextInt(6) + 1;
              print(randomNo);
              toAnimate = false;
              ply1 == 0
                  ? randomNo == 1
                        ? ply1 = order(randomNo)
                        : ply1 = 0
                  : ply1 + randomNo > 100
                  ? ply1 = ply1
                  : ply1 = order(order(ply1) + randomNo);
              Future.delayed(Duration(seconds: 1)).whenComplete(() {
                setState(() {
                  ply1 = changeBoard
                      ? snakeLadderCmd2(ply1)
                      : snakeLadderCmd(ply1);
                });
              });
              if (ply1 == 100)
                showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                    title: new Text("Snakes & Ladders"),
                    content: new Text(
                      "Player 1 WON !!!\nDo you want to Restart ?",
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text('Yes'),
                        onPressed: () {
                          setState(() {
                            ply1 = 0;
                            ply2 = 0;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
            });
            Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
              setState(() {
                plyturn = !plyturn;
              });
            });
          });
        });
      },
      child: SizedBox(
        // height: 100,
        // width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Icon(Icons.person, color: ply1Color)),
            Expanded(
              child: Container(
                height: 150,
                child: toAnimate
                    ? Flare(animation: '1')
                    : Image.asset('assets/images/$randomNo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Snakes & Ladders',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
      elevation: 8,
      shadowColor: Colors.indigo.withOpacity(0.3),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(!isComputer ? Icons.computer : Icons.people_outline),
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (_) => new AlertDialog(
        //         title: new Text("Snakes & Ladders"),
        //         content: new Text(
        //           isComputer
        //               ? "Would you like to change Player1 to manual"
        //               : "Would you like to convert Player 1 to Computer",
        //         ),
        //         actions: <Widget>[
        //           ElevatedButton(
        //             child: Text('Yes'),
        //             onPressed: () {
        //               setState(() {
        //                 isComputer = !isComputer;
        //                 plyturn = true;
        //                 print('isComputer = $isComputer');
        //               });
        //               Navigator.of(context).pop();
        //             },
        //           ),
        //           ElevatedButton(
        //             child: Text('No'),
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //             },
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                title: new Text("Snakes & Ladders"),
                content: new Text("Would you like to restart the game?"),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('Yes'),
                    onPressed: () {
                      setState(() {
                        ply1 = 0;
                        ply2 = 0;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  int snakeLadderCmd(int ply) {
    switch (ply) {
      // Snakes
      case 99:
        ply = 66;
        break;
      case 95:
        ply = 72;
        break;
      case 79:
        ply = 49;
        break;
      case 63:
        ply = 41;
        break;
      case 56:
        ply = 36;
        break;
      case 44:
        ply = 33;
        break;
      case 37:
        ply = 30;
        break;
      case 25:
        ply = 16;
        break;
      case 21:
        ply = 3;
        break;
      case 18:
        ply = 7;
        break;

      // Ladders
      case 5:
        ply = 14;
        break;
      case 20:
        ply = 29;
        break;
      case 23:
        ply = 45;
        break;
      case 40:
        ply = 48;
        break;
      case 42:
        ply = 53;
        break;
      case 58:
        ply = 67;
        break;
      case 70:
        ply = 90;
        break;
      case 71:
        ply = 92;
        break;
      case 75:
        ply = 97;
        break;

      default:
    }
    return ply;
  }

  int snakeLadderCmd2(int ply) {
    switch (ply) {
      // Snakes
      case 17:
        ply = 6;
        break;
      case 33:
        ply = 14;
        break;
      case 39:
        ply = 28;
        break;
      case 54:
        ply = 46;
        break;
      case 81:
        ply = 43;
        break;
      case 99:
        ply = 18;
        break;

      // Ladders
      case 84:
        ply = 95;
        break;
      case 47:
        ply = 86;
        break;
      case 50:
        ply = 59;
        break;
      case 2:
        ply = 43;
        break;
      default:
    }
    return ply;
  }
}
