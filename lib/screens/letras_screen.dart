import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class LetrasScreen extends StatefulWidget {
  const LetrasScreen({Key? key}) : super(key: key);

  @override
  State<LetrasScreen> createState() => _LetrasScreenState();
}

class _LetrasScreenState extends State<LetrasScreen> {
  final List<String> letras = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T', 'U',
    'V', 'W', 'X', 'Y', 'Z'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Lengua de Señas - Letras'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amberAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
        child: CardSwiper(
          cardsCount: letras.length,
          cardBuilder: (context, index) {
            return Center(child: _buildCard(letras[index]));
          },
        ),
      ),
    );
  }

  Widget _buildCard(String letra) {
    final imagePath = 'assets/images/letras/$letra.jpg';

    return Container(
      width: 350,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade900, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.amberAccent, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Marco decorativo para la imagen
          Container(
            height: 300,
            width: 300,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Letra $letra',
            style: const TextStyle(
              color: Colors.amberAccent,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
