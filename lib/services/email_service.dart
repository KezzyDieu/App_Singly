import 'dart:io';

class EmailService {
  static Future<bool> enviarCorreoConAdjunto({
    required String destinatario,
    required File archivo,
  }) async {
    print('Enviar imagen a $destinatario: ${archivo.path}');
    return true;
  }
}
