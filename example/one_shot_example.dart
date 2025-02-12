import 'dart:io';

import 'package:one_shot/one_shot.dart';

Future<void> main() async {
  final apiKey = Platform.environment["OPEN_AI_KEY"]!;
  final britishFlag = await File("flag.png").readAsBytes();
  final prompt = """
What is the capitol of the United States of America?
What flag is this?

respond in json:
{
  capitol: string
  flag: string
}
""";

  final result = await oneShot(
    apiKey: apiKey,
    prompt: prompt,
    images: [britishFlag],
  );

  print(result); // { "capitol": "Washington DC", "flag": "Union Jack"}
}
