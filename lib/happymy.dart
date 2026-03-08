import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'home.dart';
import 'secret.dart';
import 'package:google_fonts/google_fonts.dart';

class HappyMyLove extends StatefulWidget {
  const HappyMyLove({super.key});

  @override
  State<HappyMyLove> createState() => _HappyMyLoveState();
}

class _HappyMyLoveState extends State<HappyMyLove> with TickerProviderStateMixin {
  late AnimationController _ballController;
  late AnimationController _bigBallController;

  int _secretLoveCount = 0;

  final AudioPlayer player = AudioPlayer();
  bool _showMessageBox = false;

  void _onBirthdayImageTap() async{

    _secretLoveCount++;

    print("Tap count: $_secretLoveCount");

    if (_secretLoveCount >= 5) {

      await stopMusic();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SecretLovePage()
        ),
      );
      _secretLoveCount = 0;
    }
  }

  @override
  void initState() {
    super.initState();

    // Floating balls
    _ballController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _bigBallController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    // Animated text box
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _showMessageBox = true;
      });
    });

    // Play music
    playMusic();
  }

  Future<void> playMusic() async {
    await player.setVolume(1.0);
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource('music/happyto.mp3'));
  }

  Future<void> stopMusic() async {
    await player.stop();
  }

  // Navigate back + stop music
  void navigateBack() async {
    await stopMusic();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    stopMusic(); // stop music bila page dispose
    _ballController.dispose();
    _bigBallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Background + gradient
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.pink.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // Floating balls
          AnimatedBuilder(
            animation: _ballController,
            builder: (context, child) {
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;

              return Stack(
                children: List.generate(20, (i) {
                  final random = Random(i);
                  final x = random.nextDouble() * screenWidth;
                  final progress = (_ballController.value + random.nextDouble()) % 1;
                  final y = screenHeight * progress;

                  return Positioned(
                    left: x,
                    top: y,
                    child: Container(
                      width: 10 + random.nextDouble() * 15,
                      height: 10 + random.nextDouble() * 15,
                      decoration: BoxDecoration(
                        color: Colors.primaries[i % Colors.primaries.length].withOpacity(0.75),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              );
            },
          ),

          // Back button
          Positioned(
            top: 40,
            left: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.5),
              ),
              onPressed: navigateBack,
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.black),
                  SizedBox(width: 5),
                  Text("Back", style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),

          // Main UI
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text(
                  "Happy 28th Birthday 🎉\n Mia",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 30),


                GestureDetector(
                  onTap: _onBirthdayImageTap,
                  child: Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/Mia3.png"),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.4),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  width: _showMessageBox ? 220 : 150,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0,4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      " 17 April 2026 🎂",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.pacifico(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF100707),
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  width: _showMessageBox ? 350 : 200,
                  height: _showMessageBox ? 180 : 50,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 800),
                    style: GoogleFonts.lobster(
                        fontSize: _showMessageBox ? 20 : 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF232020),
                        shadows: [
                          Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 2,
                              color: Color(0xFF7C2E40)
                          )
                        ]
                    ),
                    child: Text(
                      _showMessageBox
                          ? "Saya doa kan Mia dipermudahkan segala urusan serta dilindungi daripada sebarang keburukan dan jaga diri banyak kan makan dan minum. Saya doa kan keinginan yang Mia nak tercapai 🎂🎉"
                          : "Happy Birthday Mia 🎂",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}