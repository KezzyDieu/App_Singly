// lib/utils/url_launcher_service.dart
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  // Función para lanzar la URL (abrir enlaces)
  static Future<void> launchURL(String url) async {
    // Verifica si la URL es válida
    if (await canLaunch(url)) {
      await launch(url); // Abre la URL
    } else {
      throw 'No se puede abrir el enlace: $url';
    }
  }
}