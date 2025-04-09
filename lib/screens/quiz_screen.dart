import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class QuizScreen extends StatefulWidget {
  final String email;

  const QuizScreen({super.key, required this.email});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<String> _letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  final List<String> _cartasAleatorias = [];
  int _aciertos = 0;
  int _indiceActual = 0;
  String? _letraEsperada;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _generarCartasAleatorias();
    _iniciarTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _iniciarTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
      await _obtenerLetraDesdeDB();
      _verificarYAvanzar();
    });
  }

  void _generarCartasAleatorias() {
    final random = Random();
    while (_cartasAleatorias.length < 10) {
      final letra = _letras[random.nextInt(_letras.length)];
      if (!_cartasAleatorias.contains(letra)) {
        _cartasAleatorias.add(letra);
      }
    }
  }

  Future<void> _obtenerLetraDesdeDB() async {
    final letra = await ApiService.obtenerUltimaLetra();
    setState(() {
      _letraEsperada = letra;
    });
  }

  void _verificarYAvanzar() {
    final letraActual = _cartasAleatorias[_indiceActual];
    if (letraActual == _letraEsperada) {
      _aciertos++;
    }

    if (_indiceActual < _cartasAleatorias.length - 1) {
      setState(() {
        _indiceActual++;
        _letraEsperada = null;
      });
    } else {
      _timer?.cancel();
      _mostrarResultadoFinal();
    }
  }

  void _mostrarResultadoFinal() {
    Navigator.pushReplacementNamed(
      context,
      '/resultados',
      arguments: {
        'aciertos': _aciertos,
        'total': _cartasAleatorias.length,
        'email': widget.email,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final letraActual = _cartasAleatorias[_indiceActual];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Quiz de Letras"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amberAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Carta ${_indiceActual + 1} de ${_cartasAleatorias.length}',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Expanded(child: Center(child: _buildCard(letraActual))),
              const SizedBox(height: 20),
              _letraEsperada == null
                  ? const Column(
                    children: [
                      CircularProgressIndicator(color: Colors.amberAccent),
                      SizedBox(height: 10),
                      Text(
                        "Esperando lectura del dispositivo...",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  )
                  : Text(
                    "Letra leída: $_letraEsperada",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent,
                    ),
                  ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String letra) {
    final imagePath = 'assets/images/letras/$letra.jpg';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amberAccent, width: 3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Letra $letra',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
