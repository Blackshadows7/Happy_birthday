import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'happymy.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playMusic();
  }

  Future<void> playMusic() async {
    await player.setVolume(1.0);
    await player.play(
      AssetSource('music/happypiano.mp3'),
    );
  }
  
  Future<void> stopMusic() async {
    await player.stop();
  }
  
  @override
  void dispose() {
    stopMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE6E1),
      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 IMAGE
            Positioned(
              top: 5,
              left: 5,
              right: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  "assets/Mia4.png",
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// 🔹 CURVED WHITE SECTION
            Positioned(
              top: 430,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),

                      /// TITLE
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E1E3F),
                          ),
                          children: [
                            const TextSpan(text: "Happy 28th Birthday\n "),
                            TextSpan(
                              text: "Mia",
                              style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFD2A48F),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// DESCRIPTION
                      Text(
                        "Press the button to continue\nthe birthday surprise.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// DOT
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD2A48F),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// BUTTON
                      SizedBox(
                        width: 220,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD2A48F),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          /// 🔥 BUTTON ACTION
                          onPressed: () async {
                            // STOP MUSIC SEBELUM NAVIGATE
                            await stopMusic();

                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                const HappyMyLove(),

                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  final offsetAnimation = Tween(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },

                                transitionDuration: const Duration(milliseconds: 600),
                              ),
                            );
                          },

                          child: Text(
                            "Get Started",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
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

/// CURVE SHAPE
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 60);
    path.quadraticBezierTo(size.width / 2, -20, size.width, 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
