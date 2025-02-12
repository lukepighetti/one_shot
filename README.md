# one_shot

Build simple LLM applications fast. Works with any LLM provider that uses the Open AI chat completions protocol.

```dart
import 'dart:convert';
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
```


## Promises

- Can use any Open AI protocol compliant LLM service
- Support text and images in prompts
- Return `Map<String, dynamic>`
- Open AI endpoints and models will work
- Keep things simple with [JSON Mode](https://platform.openai.com/docs/guides/structured-outputs#structured-outputs-vs-json-mode) until we have [data classes that can self-describe their JSON shape](https://github.com/schultek/dart_mappable/issues/269)


## Contributing

- Add endpoints and models that are compliant
- Add token metadata logging
- Add temperature controls

## Credits

The album that wrote this package: https://open.spotify.com/album/1tr3wtSgVZbk6xFLQpVDdA
