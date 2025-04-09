import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ResultScreen extends StatefulWidget {
  final int aciertos;
  final String email;

  const ResultScreen({super.key, required this.aciertos, required this.email});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _enviarAutomaticamenteAlCorreo();
    });
  }

  Future<void> _guardarImagenLocal() async {
    final Uint8List? imgBytes = await _screenshotController.capture();
    if (imgBytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/resultado.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(imgBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Imagen guardada localmente')),
      );
    }
  }

  Future<void> _enviarAutomaticamenteAlCorreo() async {
    final Uint8List? imgBytes = await _screenshotController.capture();
    if (imgBytes != null) {
      final uri = Uri.parse('https://apisofccey.onrender.com/api/email/enviar');
      final request =
          http.MultipartRequest('POST', uri)
            ..fields['email'] = widget.email
            ..files.add(
              http.MultipartFile.fromBytes(
                'imagen',
                imgBytes,
                filename: 'resultado.png',
                contentType: MediaType('image', 'png'),
              ),
            );

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Correo enviado correctamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Error al enviar el correo')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: _screenshotController,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/fondoresults.jpg', fit: BoxFit.cover),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1C40F),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Tu resultado fue:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${widget.aciertos} de 10',
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [Shadow(blurRadius: 4, color: Colors.white)],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: _guardarImagenLocal,
                      icon: const Icon(Icons.save),
                      label: const Text("Guardar imagen"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.9),
                        foregroundColor: Colors.amber,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _enviarAutomaticamenteAlCorreo,
                      icon: const Icon(Icons.email),
                      label: const Text("Reenviar al correo"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
