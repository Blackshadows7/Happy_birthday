import 'package:flutter/material.dart';
import 'package:happymia/happymy.dart';



class SecretLovePage extends StatelessWidget {
  const SecretLovePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌄 Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/green.jpg"), // tukar ikut gambar awak
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌟 Gradient overlay untuk effect lembut
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🔹 Kotak dengan ayat love
          Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85), // semi-transparent
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Text(
                "Saya sayang Mia sangat-sangat walau apa pun saya tetap sayang Mia. sayang saya, sentiasa bertambah setiap hari tidak berkurang. 🌞\n\n"
                    "Mia, walaupun saya lambat disebabkan sambung belajar serta apa-apa berlaku saya tetap sayang Mia💖\n\n"
                    "Saya sentiasa berdoa dan bergantung 100% kepada Allah untuk memudahkan segala urusan💕\n\n"
                    "Because a girl like you is impossible to find 💖\n\n"
                    "I promise, I'll love you forever and ever and always 💖\n\n"
                    "Every day with you is special 💕\n\n"
                    " Hamzah# 💕\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),

          // 🔙 Back button ke MyHomepage
          Positioned(
            top: 40,
            left: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HappyMyLove(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}