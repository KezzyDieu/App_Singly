import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼 Imagen superior
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/sofcay_image.jpg',
                    width: 280,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🔸 Título
              const Text(
                '¿Qué es SOFCEY?',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                ),
              ),
              const SizedBox(height: 14),

              const Text(
                'SOFCEY es una solución tecnológica inclusiva que permite aprendeer el lenguaje de señas mexicana (LSM). Esto permite la comunicación entre personas con discapacidad auditiva y oyentes. El sistema se basa en un guante inteligente con sensores que capturan los movimientos y los interpretan mediante una placa de desarrollo.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),

              const Text(
                'Características',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                ),
              ),
              const SizedBox(height: 20),

              // 🔄 Carrusel de características
              SizedBox(
                height: 220,
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildFeatureCard(
                      icon: Icons.accessibility_new,
                      title: 'Inclusión',
                      description:
                          'Diseñado para ayudar a personas con discapacidad auditiva a comunicarse de forma efectiva.',
                    ),
                    _buildFeatureCard(
                      icon: Icons.precision_manufacturing,
                      title: 'Precisión',
                      description:
                          'Detecta movimientos exactos de los dedos y manos con sensores avanzados.',
                    ),
                    _buildFeatureCard(
                      icon: Icons.auto_graph,
                      title: 'Innovación',
                      description:
                          'Tecnologías modernas de software y hardware para una experiencia fluida.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 🌐 Botón
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    _launchURL('https://sofccey.onrender.com/descargar.html');
                  },
                  icon: const Icon(Icons.language),
                  label: const Text('Visitar Página Web'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.amberAccent, size: 50),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }
}
