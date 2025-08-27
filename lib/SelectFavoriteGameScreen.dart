import 'package:flutter/material.dart';
import 'MainNavigationScreen.dart';
import 'package:snackandladder/Utils/common.dart';

class SelectFavoriteGameScreen extends StatefulWidget {
  const SelectFavoriteGameScreen({super.key});

  @override
  _SelectFavoriteGameScreenState createState() =>
      _SelectFavoriteGameScreenState();
}

class _SelectFavoriteGameScreenState extends State<SelectFavoriteGameScreen> {
  Set<String> selectedCategories = {};

  final List<Map<String, dynamic>> gameCategories = [
    {
      'name': 'Adventure',
      'icon': Icons.landscape,
      'color': Colors.orange,
      'emoji': '🏔️',
    },
    {'name': 'Card', 'icon': Icons.style, 'color': Colors.blue, 'emoji': '🃏'},
    {
      'name': 'Casual',
      'icon': Icons.games,
      'color': Colors.green,
      'emoji': '🎮',
    },
    {
      'name': 'Puzzle',
      'icon': Icons.extension,
      'color': Colors.purple,
      'emoji': '🧩',
    },
    {
      'name': 'Racing',
      'icon': Icons.directions_car,
      'color': Colors.red,
      'emoji': '🏎️',
    },
    {
      'name': 'Simulation',
      'icon': Icons.build,
      'color': Colors.teal,
      'emoji': '🏭',
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_soccer,
      'color': Colors.indigo,
      'emoji': '⚽',
    },
    {
      'name': 'Strategy',
      'icon': Icons.psychology,
      'color': Colors.amber,
      'emoji': '🎯',
    },
    {
      'name': 'Words',
      'icon': Icons.text_fields,
      'color': Colors.pink,
      'emoji': '📝',
    },
    {
      'name': 'Survival Horror',
      'icon': Icons.warning,
      'color': Colors.red.shade800,
      'emoji': '👻',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Select Favorite Game Categories',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'select the categories you love to explore.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: gameCategories.length,
                        itemBuilder: (context, index) {
                          final category = gameCategories[index];
                          final isSelected = selectedCategories.contains(
                            category['name'],
                          );

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? category['color']
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CheckboxListTile(
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (isSelected) {
                                    selectedCategories.remove(category['name']);
                                  } else {
                                    selectedCategories.add(category['name']);
                                  }
                                });
                              },
                              title: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: category['color'].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        category['emoji'],
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      category['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isSelected
                                            ? category['color']
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              activeColor: category['color'],
                              checkColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: selectedCategories.isNotEmpty
                            ? () {
                                if (Common.adsopen == "1") {
                                  Common.openUrl();
                                }
                                // Set firstTime to "0" so next time app opens directly to MainNavigationScreen
                                Common.firstTime = "0";
                                Common.setFirstTime("0");
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const MainNavigationScreen(),
                                    transitionsBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                        ) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          );
                                        },
                                    transitionDuration: const Duration(
                                      milliseconds: 500,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      ),
    );
  }
}
