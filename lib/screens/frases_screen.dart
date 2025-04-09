import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FrasesScreen extends StatelessWidget {
  const FrasesScreen({super.key});

  final List<Map<String, String>> frases = const [
    {
      'emoji': '👋',
      'texto': 'Hola',
      'descripcion':
          'Mano abierta, movimiento de saludo como si dijeras "hola" en voz alta.',
    },
    {
      'emoji': '🤲',
      'texto': 'Gracias',
      'descripcion':
          'Mano plana frente a la boca que se aleja hacia adelante, como mandando un besito con la palma.',
    },
    {
      'emoji': '✊',
      'texto': 'Sí',
      'descripcion':
          'Mano en forma de puño, moviendo hacia arriba y abajo como si estuvieras asintiendo.',
    },
    {
      'emoji': '🤏',
      'texto': 'No',
      'descripcion':
          'Juntas el pulgar y el dedo medio, y haces un movimiento rápido hacia los lados, como diciendo "no".',
    },
    {
      'emoji': '👉',
      'texto': 'Yo',
      'descripcion': 'Señalas hacia ti mismo con el dedo índice.',
    },
    {
      'emoji': '👉',
      'texto': 'Tú',
      'descripcion': 'Señalas hacia la otra persona con el dedo índice.',
    },
    {
      'emoji': '✌️',
      'texto': 'Amigo / Amiga',
      'descripcion':
          'Se cruzan los dedos índice y medio, como cruzar los dedos para la suerte.',
    },
    {
      'emoji': '👋',
      'texto': 'Bien',
      'descripcion':
          'Mano plana frente a la boca, como "gracias", pero con expresión facial positiva.',
    },
    {
      'emoji': '✋',
      'texto': 'Mal',
      'descripcion':
          'Palma hacia abajo y haces un giro como volteándola, con expresión facial seria.',
    },
    {
      'emoji': '🤲',
      'texto': 'Por favor',
      'descripcion':
          'Mano extendida haciendo un pequeño círculo frente al pecho.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      appBar: AppBar(
        title: const Text('Frases con una sola mano'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amberAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: CardSwiper(
          cardsCount: frases.length,
          cardBuilder: (context, index) {
            return Center(child: _buildFraseCard(context, frases[index]));
          },
        ),
      ),
    );
  }

  Widget _buildFraseCard(BuildContext context, Map<String, String> frase) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        // Degradado sutil de negro a gris oscuro
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.amberAccent, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              frase['emoji']!,
              style: const TextStyle(fontSize: 60),
            ),
            const SizedBox(height: 20),
            Text(
              frase['texto']!,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.amberAccent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              frase['descripcion']!,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
