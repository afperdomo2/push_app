/// Utilidades para el manejo de mensajes push
class MessageUtils {
  /// Limpia el messageId removiendo caracteres especiales que pueden causar problemas en las URLs
  static String cleanMessageId(String? messageId) {
    return messageId?.replaceAll(':', '').replaceAll('%', '') ?? 'no-id';
  }
}
