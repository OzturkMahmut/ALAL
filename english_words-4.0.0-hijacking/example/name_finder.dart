// Copyright (c) 2020, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:english_words/english_words.dart';

void main() {
  for (final word in nouns) {
    final compound = "moon${word}";
    if (syllables(compound) <= 2) {
      print(compound);
    }
  }
}
