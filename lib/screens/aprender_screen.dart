import 'package:flutter/material.dart';
import 'letras_screen.dart';
import 'frases_screen.dart';

class AprenderScreen extends StatefulWidget {
  const AprenderScreen({super.key});

  @override
  State<AprenderScreen> createState() => _AprenderScreenState();
}

class _AprenderScreenState extends State<AprenderScreen> {
  int selectedStage = 0;

  final List<Map<String, dynamic>> stages = [
    {
      'nombre': 'Abecedario',
      'contenido': [
        {
          'titulo': 'Aprende el Abecedario',
          'descripcion': 'Explora las letras en LSM',
          'imagen': 'assets/images/letras.jpg',
          'pantalla': const LetrasScreen(),
          'bloqueado': false,
        },
        {
          'titulo': 'Alfabeto en LSM Inglés',
          'descripcion': 'Próximamente...',
          'imagen': '',
          'pantalla': null,
          'bloqueado': true,
        },
      ]
    },
    {
      'nombre': 'Frases comunes',
      'contenido': [
        {
          'titulo': 'Frases básicas',
          'descripcion': 'Saluda, agradece y más',
          'imagen': 'assets/images/frases.jpg',
          'pantalla': const FrasesScreen(),
          'bloqueado': false,
        },
        {
          'titulo': 'Frases con dos manos',
          'descripcion': 'Contenido avanzado',
          'imagen': '',
          'pantalla': null,
          'bloqueado': true,
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    final currentStage = stages[selectedStage];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📘 Aprender LSM',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.amberAccent,
              ),
            ),
            const SizedBox(height: 20),

            // Menú de categorías
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(stages.length, (index) {
                  final selected = index == selectedStage;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedStage = index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected ? Colors.amberAccent : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.amberAccent),
                        ),
                        child: Text(
                          stages[index]['nombre'],
                          style: TextStyle(
                            color: selected ? Colors.black : Colors.amberAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 25),

            // Tarjetas del contenido
            Expanded(
              child: ListView.builder(
                itemCount: currentStage['contenido'].length,
                itemBuilder: (context, i) {
                  final item = currentStage['contenido'][i];
                  return item['bloqueado']
                      ? _buildLockedCard(item['titulo'], item['descripcion'])
                      : _buildCard(
                          context,
                          item['titulo'],
                          item['descripcion'],
                          item['imagen'],
                          item['pantalla'],
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🟢 Tarjetas disponibles
  Widget _buildCard(
    BuildContext context,
    String titulo,
    String descripcion,
    String imagen,
    Widget pantalla,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => pantalla));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            image: AssetImage(imagen),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 10, offset: Offset(0, 6))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                descripcion,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔒 Tarjetas bloqueadas
  Widget _buildLockedCard(String titulo, String descripcion) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock, color: Colors.white54, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  descripcion,
                  style: const TextStyle(color: Colors.white38),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
