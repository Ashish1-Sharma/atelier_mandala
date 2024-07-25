import 'dart:math';
class GenerateUid{
 static String generateRandomString() {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        12, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}