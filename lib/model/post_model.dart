import 'package:jaguar_jwt/jaguar_jwt.dart';

String decodeJWT(String encoded, String key) {
  JwtClaim decClaimSet;
  try {
    decClaimSet = verifyJwtHS256Signature(encoded, key);
  } on JwtException {}

  return decClaimSet.toString();
}

String encodeJWT(Map<String, dynamic> data, String key) {
  final claimSet = new JwtClaim(
    otherClaims: <String, dynamic>{
      'payload': data,
    },
  );
  
  return issueJwtHS256(claimSet, key);
}

String postToJson(Map<String, dynamic> data, String key) {
  return encodeJWT(data, key);
}
