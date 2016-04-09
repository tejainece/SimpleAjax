import "package:pointycastle/pointycastle.dart";
import "package:pointycastle/impl.dart";
import "dart:typed_data";

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

void _assertRemainingBufferIsZero(Uint8List out, int offset) {
  if (offset < out.lengthInBytes) {
    print("error1");
  }
}

Uint8List _processBlocks(BlockCipher cipher, Uint8List inp) {
  var out = new Uint8List(inp.lengthInBytes);
  for (var offset = 0; offset < inp.lengthInBytes;) {
    var len = cipher.processBlock(inp, offset, out, offset);
    offset += len;
    _assertRemainingBufferIsZero(out, offset);
  }
  return out;
}

Uint8List encrypt(BlockCipher cipher, aParams, String aTxt) {
  var plainText = createUint8ListFromString(aTxt);
  print(plainText.lengthInBytes);

  cipher
    ..reset()
    ..init(true, aParams);

  var lEncrypted = _processBlocks(cipher, plainText);
  return lEncrypted;
}

dynamic decrypt(BlockCipher cipher, aParams, Uint8List aTxt) {
  print(aTxt.lengthInBytes);

  cipher
    ..reset()
    ..init(false, aParams);

  var lEncrypted = _processBlocks(cipher, aTxt);
  return lEncrypted;
}

main() {
  final key = new Uint8List.fromList([
    0x00,
    0x11,
    0x22,
    0x33,
    0x44,
    0x55,
    0x66,
    0x77,
    0x88,
    0x99,
    0xAA,
    0xBB,
    0xCC,
    0xDD,
    0xEE,
    0xFF
  ]);
  final iv = new Uint8List.fromList([
    10,
    11,
    12,
    12,
    13,
    16,
    11,
    14,
    16,
    5,
    8,
    99,
    45,
    23,
    84,
    34
  ]);
  KeyParameter params = new KeyParameter(key);
  BlockCipher cipher = new BlockCipher("AES");

  //KeyParameter keyParam = new KeyParameter(key);
  //ParametersWithIV params = new ParametersWithIV(keyParam, key);
  //BlockCipher cipher = new BlockCipher("AES/CBC");

  final plainTextString =
"""how are you? Tej""";

  Uint8List lEncrypted = encrypt(cipher, params, plainTextString);
  print(lEncrypted);

  Uint8List ldecrypted = decrypt(cipher, params, lEncrypted);
  print(ldecrypted);

  String lText = new String.fromCharCodes(ldecrypted);
  print(lText);
}
