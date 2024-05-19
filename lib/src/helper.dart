import 'dart:convert';

/// just helper function
/// for beauty look on web github
String prettyByte(Map<String, dynamic> object) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(object);
  List<int> byte = pretty.codeUnits;
  return base64Encode(byte);
}
