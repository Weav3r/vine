import 'dart:typed_data';

bool isEmailSimd(String input) {
  final atIndex = input.indexOf('@');
  if (atIndex == -1 || atIndex == 0 || atIndex == input.length - 1) {
    return false;
  }

  final domainPart = input.substring(atIndex + 1);

  if (domainPart.isEmpty || !domainPart.contains('.')) {
    return false;
  }

  final bytes = input.codeUnits;
  final int len = bytes.length;

  // Traitement SIMD par paquets de 4 caractères
  for (int i = 0; i < len - 3; i += 4) {
    final vector = Int32x4(bytes[i], bytes[i + 1], bytes[i + 2], bytes[i + 3]);

    // Vérification rapide de la présence de caractères interdits (ex: espaces)
    if ((vector & Int32x4(0x20, 0x20, 0x20, 0x20)) == Int32x4(0x20, 0x20, 0x20, 0x20)) {
      return false;
    }
  }

  return true;
}
