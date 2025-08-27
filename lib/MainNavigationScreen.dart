import 'package:flutter/material.dart';
import 'package:snackandladder/share_service.dart';
import 'GameModeScreen.dart';
import 'package:snackandladder/Utils/common.dart';
import 'feedback_service.dart';
import 'game/game_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 2; // Start with center tab (All Game)

  final List<Widget> _screens = [
    const QuizScreen(),
    const PrivacyScreen(),
    const AllGameScreen(),
    const ShareScreen(),
    const RateUsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitDialog(context);
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  if (index != 2) {
                    if (Common.adsopen == "1") {
                      Common.openUrl();
                    }
                  }
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.quiz, size: 32),
                  label: 'Quiz',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.security, size: 32),
                  label: 'Privacy',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(), // Placeholder for center
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.share, size: 32),
                  label: 'Share',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.thumb_up, size: 32),
                  label: 'Rate Us',
                ),
              ],
            ),

            /// Floating center icon
            Positioned.fill(
              top: -35, // lift effect
              child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: _currentIndex == 2 ? Colors.red : Colors.grey,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _currentIndex == 2
                                  ? Colors.red.withOpacity(0.4)
                                  : Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.sports_esports, // Game icon
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "All Game",
                        style: TextStyle(
                          color: _currentIndex == 2 ? Colors.red : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                          'Exit App',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Message
                        const Text(
                          'Are you sure you want to exit the app?',
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

// Quiz Screen
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade100, Colors.blue.shade50],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Common.Qurekaid.isNotEmpty
                  ? const InkWell(
                      onTap: Common.openUrl,
                      child: Image(
                        image: AssetImage("assets/images/qurekaads2.png"),
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(),
              Icon(Icons.quiz, size: 100, color: Colors.blue.shade600),
              const SizedBox(height: 20),
              Text(
                'Quiz Section',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Test your knowledge with fun quizzes!',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (Common.Qurekaid.isNotEmpty) {
                    Common.openUrl();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Privacy Screen
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade100, Colors.green.shade50],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Common.Qurekaid.isNotEmpty
                ? const InkWell(
                    onTap: Common.openUrl,
                    child: Image(
                      image: AssetImage("assets/images/qurekaads3.png"),
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(),
            Icon(Icons.security, size: 100, color: Colors.green.shade600),
            const SizedBox(height: 20),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Text(
                'Your privacy is important to us. We collect only necessary data to provide you with the best gaming experience. We never share your personal information with third parties.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// All Game Screen
class AllGameScreen extends StatelessWidget {
  const AllGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Games'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            Common.Qurekaid.isNotEmpty
                ? InkWell(
                    onTap: Common.openUrl,
                    child: Image(
                      width: MediaQuery.of(context).size.width,
                      image: const AssetImage("assets/images/qurekaads.png"),
                      fit: BoxFit.fill,
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Snake & Ladder Card
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (Common.adsopen == "1") {
                          Common.openUrl();
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GameModeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 180,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade600,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.casino,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Snake & Ladder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Classic Board Game",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // All Games Card
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (Common.adsopen == "1") {
                          Common.openUrl();
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => GameScreen()),
                        );
                      },
                      child: Container(
                        height: 180,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade400,
                              Colors.green.shade600,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.games,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "All Games",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Browse Categories",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Common.Qurekaid.isNotEmpty
                ? InkWell(
                    onTap: Common.openUrl,
                    child: Image(
                      width: MediaQuery.of(context).size.width,
                      image: const AssetImage("assets/images/bannerads.png"),
                      fit: BoxFit.fill,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, int index) {
    final games = [
      {'name': 'Snake & Ladder', 'icon': Icons.games, 'color': Colors.blue},
      {'name': 'Ludo Master', 'icon': Icons.casino, 'color': Colors.green},
      {'name': 'Chess', 'icon': Icons.sports_esports, 'color': Colors.orange},
      {'name': 'Puzzle', 'icon': Icons.extension, 'color': Colors.purple},
      {'name': 'Memory', 'icon': Icons.memory, 'color': Colors.teal},
      {'name': 'Racing', 'icon': Icons.directions_car, 'color': Colors.red},
    ];

    final game = games[index % games.length];

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GameModeScreen()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: game['color'] as Color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                game['icon'] as IconData,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              game['name'] as String,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              'Tap to play',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

// Share Screen
class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade100, Colors.purple.shade50],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Common.Qurekaid.isNotEmpty
                  ? const InkWell(
                      onTap: Common.openUrl,
                      child: Image(
                        image: AssetImage("assets/images/qurekaads4.png"),
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(),
              Icon(Icons.share, size: 100, color: Colors.purple.shade600),
              const SizedBox(height: 20),
              Text(
                'Share with Friends',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Invite your friends to play!',
                style: TextStyle(fontSize: 16, color: Colors.purple.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareButton(
                    Icons.facebook_outlined,
                    'Facebook',
                    Colors.blue,
                  ),
                  _buildShareButton(Icons.message, 'WhatsApp', Colors.green),
                  _buildShareButton(Icons.send, 'Telegram', Colors.lightBlue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            ShareService.shareAppOnSocialMedia();
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// Rate Us Screen
class RateUsScreen extends StatelessWidget {
  const RateUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Us'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade100, Colors.orange.shade50],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Common.Qurekaid.isNotEmpty
                  ? const InkWell(
                      onTap: Common.openUrl,
                      child: Image(
                        image: AssetImage("assets/images/qurekaads5.png"),
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(),
              Icon(Icons.thumb_up, size: 100, color: Colors.orange.shade600),
              const SizedBox(height: 20),
              Text(
                'Rate Our App',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your feedback helps us improve!',
                style: TextStyle(fontSize: 16, color: Colors.orange.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 40,
                    color: index < 4 ? Colors.orange : Colors.grey.shade300,
                  );
                }),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  FeedbackService.openPlayStoreFeedback();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text('Rate on Play Store'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
