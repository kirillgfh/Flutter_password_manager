import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

var sp = [md5, sha1, sha256, sha224, sha512] ;
// ignore: non_constant_identifier_names

void main() {
  var bytes = utf8.encode("dart"); // data being hashed
  var digest = md5.convert(bytes);
  print(bytes);
  digest = md5.convert(bytes);
  digest = sha1.convert(bytes);
  digest = sp[0].convert(bytes);

  print("Digest as bytes: ${digest.bytes}");
  print("Digest as hex string: $digest");
  Map<String, dynamic> map = {
    'list' : [ ['cock', 'dick'], ['cock2', 'dick2'] ]
  };
  var rawJson = jsonEncode(map);
  print(rawJson);

  Map<String, dynamic> mapp = jsonDecode(rawJson);
  print(mapp['list'][0][0]);

  // var a = '123';
  // print(a.split(''));
}