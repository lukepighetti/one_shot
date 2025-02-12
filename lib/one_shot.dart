library;

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

/// Provide a prompt and optional images, get back JSON.
///
/// You must ask for JSON in the prompt.
///
/// ```dart
/// oneShot(
///   apiKey: apiKey,
///   prompt: 'what is the USA capitol? json: {"capitol": string}',
/// ).then(print); // {"capitol": "Washington DC"}
/// ```
///
/// You can also provide images in png format encoded to base64
///
/// ```dart
/// final bird = await File("bird.png").readAsBytes();
///
/// oneShot(
///   apiKey: apiKey,
///   images: [bird],
///   prompt: 'kind of bird is this? json: {"species": string}',
/// ).then(print); // {"species": "Baltimore Oriole"}
/// ```
Future<Map<String, dynamic>> oneShot({
  required String apiKey,
  required String prompt,
  List<Uint8List> images = const [],
  List<String> base64Images = const [],
  String model = Models.gpt4o,
  String url = Endpoints.openai,
}) async {
  base64Images = [...images.map(base64Encode), ...base64Images];

  final res = await http.post(
    Uri.parse(url),
    headers: {
      "content-type": "application/json",
      "authorization": "Bearer $apiKey",
    },
    body: jsonEncode({
      "model": model,
      "response_format": {"type": "json_object"},
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": prompt,
            },
            for (final x in base64Images)
              {
                "type": "image_url",
                "image_url": {"url": "data:image/png;base64,$x"},
              }
          ]
        }
      ]
    }),
  );
  final body = utf8.decode(res.bodyBytes);
  final json = jsonDecode(body);
  final msg = (json["choices"] as List?)?.firstOrNull?["message"]["content"];
  return jsonDecode(msg);
}

/// Known endpoints that use the Open AI API protocol
class Endpoints {
  // Open AI
  static const openai = "https://api.openai.com/v1/chat/completions";
}

/// Common model keys
class Models {
  // Open AI GPT-4o
  static const gpt4o = "gpt-4o";

  // Open AI GPT-4o Mini
  static const gpt4oMini = "gpt-4o-mini";
}
