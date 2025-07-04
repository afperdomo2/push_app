import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/config/helpers/message_utils.dart';

/// Handler para manejar mensajes de Firebase cuando la aplicación está en segundo plano o cerrada
///
/// Esta función se ejecuta cuando llega un mensaje push y la aplicación no está activa.
/// Es importante que sea una función de nivel superior (no puede ser un método de clase)
/// para que Firebase pueda ejecutarla correctamente.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Si vas a utilizar otros servicios de Firebase en segundo plano, como Firestore,
  // asegúrate de llamar a `initializeApp` antes de usar otros servicios de Firebase.
  await Firebase.initializeApp();

  // Procesar el mensaje y generar un ID limpio
  final messageId = MessageUtils.cleanMessageId(message.messageId);

  // ignore: avoid_print
  print('🔄 Manejando un mensaje en segundo plano: $messageId');

  // Aquí podrías agregar lógica adicional como:
  // - Guardar el mensaje en una base de datos local
  // - Enviar analytics
  // - Procesar datos específicos del mensaje
  // - etc.
}
