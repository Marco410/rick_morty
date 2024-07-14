import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty/presentation/models/models.dart';

import '../../../config/constants/constants.dart';
import '../../../config/services/http_service.dart';

final filterCharacterProvider =
    StateProvider.autoDispose<FilterCharacter>((ref) {
  FilterCharacter filters = FilterCharacter(name: "", page: 1);
  return filters;
});

final charactersProvider =
    FutureProvider.autoDispose<List<Character>>((ref) async {
  final filters = ref.watch(filterCharacterProvider);
  final currentPage = ref.read(currentPageProvider);

  final bodyData = {
    "page": filters.page.toString(),
  };

  if (filters.name != "") {
    bodyData["name"] = filters.name;
  }

  String? resp =
      await BaseHttpService.baseGet(url: getCharacters, params: bodyData);

  if (resp != null) {
    final Map<String, dynamic> decode = json.decode(resp);

    if (decode['error'] != null) {
      return [];
    }

    CharacterModel characterList = characterModelFromJson(resp);
    if (filters.page == 1 ||
        (currentPage == filters.page &&
            filters.page != characterList.info.pages)) {
      ref.read(currentPageProvider.notifier).update((state) => 1);
      ref
          .read(characterListProvider.notifier)
          .update((state) => characterList.character);
    } else if (currentPage < characterList.info.pages) {
      List<Character> list = ref.read(characterListProvider);
      list.addAll(characterList.character);
      ref.read(characterListProvider.notifier).update((state) => list);
      ref.read(currentPageProvider.notifier).update((state) => currentPage + 1);
    }

    return characterList.character;
  } else {
    return [];
  }
});

final characterListProvider = StateProvider<List<Character>>((ref) {
  return [];
});

final currentPageProvider = StateProvider<int>((ref) {
  return 1;
});
