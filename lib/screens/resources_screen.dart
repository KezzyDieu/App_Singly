import 'package:flutter/material.dart';
import '../utils/url_launcher_service.dart';

class ResourcesScreen extends StatelessWidget {
  ResourcesScreen({super.key});

  final List<Map<String, String>> recursos = [
    {
      "tipo": "Video",
      "titulo": "Aprende la lengua de señas Mexicana con María José Hernández",
      "descripcion": "Aprende palabras en LSM",
      "url": "https://www.youtube.com/watch?v=MZOUTIjz4ac"
    },
    {
      "tipo": "Video",
      "titulo": "Bienvenidos a la Academia de Lengua de Señas Mexicana del DIF de la Ciudad de México ",
      "descripcion": "Clases de Lengua de señas Mexicana",
      "url": "https://www.tiktok.com/@lsmacademia.cdmx/video/7197618572523310341"
    },
    {
      "tipo": "Video",
      "titulo": "25 palabras y frases en LSM para principiantes. Aprende Lengua de Señas Mexicana.",
      "descripcion": "Vídeo de LSM para principiantes",
      "url": "https://www.youtube.com/watch?v=MZOUTIjz4ac"
    },
    {
      "tipo": "Página",
      "titulo": "Lengua de Señas Mexicana",
      "descripcion": "Glosario Digital de Lengua de Señas Mexicana (GDLSM)",
      "url": "https://lsm.indiscapacidad.cdmx.gob.mx/"
    },
    {
      "tipo": "Página",
      "titulo": "Aprendiendo Lengua de Señas Mexicana",
      "descripcion": "Aprende la lengua de señas a través de vídeos gratuitos",
      "url": "https://www.aprendemas.com/mx/blog/idiomas-y-comunicacion/aprende-la-lengua-de-senas-a-traves-de-videos-gratuitos-en-internet-de-youtube-a-tiktok-104417"
    },
    {
      "tipo": "Página",
      "titulo": "ACADEMIA LSM",
      "descripcion": "Cursos de Lengua de Señas Mexicana",
      "url": "https://www.lsm.cdmx.gob.mx/"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        children: [
          const Text(
            '📚 Recursos de LSM',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explora materiales de apoyo en lenguaje de señas',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),

          // Lista de tarjetas
          ...List.generate(recursos.length, (index) {
            final recurso = recursos[index];
            final isVideo = recurso['tipo'] == 'Video';
            final iconPath = isVideo ? 'assets/images/video.png' : 'assets/images/pagina.png';
            return _buildResourceCard(context, recurso, iconPath);
          }),
        ],
      ),
    );
  }

  Widget _buildResourceCard(BuildContext context, Map<String, String> recurso, String iconPath) {
    final isVideo = recurso['tipo'] == 'Video';
    final tipoColor = isVideo ? Colors.amberAccent : Colors.greenAccent;

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 6,
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              iconPath,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: tipoColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    recurso['tipo']!,
                    style: TextStyle(
                      color: tipoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  recurso['titulo']!,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  recurso['descripcion']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.open_in_new_rounded, color: Colors.amberAccent),
                    onPressed: () {
                      UrlLauncherService.launchURL(recurso['url']!);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
