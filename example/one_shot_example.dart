import 'dart:convert';
import 'dart:io';

import 'package:one_shot/one_shot.dart';

Future<void> main() async {
  final apiKey = Platform.environment["OPEN_AI_KEY"]!;
  final britishFlag = await File("flag.png").readAsBytes().then(base64Encode);
  final prompt = """
What is the capital of the United States of America?
What flag is this?

respond in json:
{
  capital: string
  flag: string
}
""";

  final result = await oneShot(
    apiKey: apiKey,
    prompt: prompt,
    base64Images: [britishFlag],
  );

  print(result); // { "capital": "Washington DC", "flag": "Union Jack"}
}
