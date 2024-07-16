import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty/presentation/models/models.dart';

import '../../../config/constants/constants.dart';
import '../../../config/services/http_service.dart';

/// Provider to get the filters applied by user
final filterCharacterProvider =
    StateProvider.autoDispose<FilterCharacter>((ref) {
  FilterCharacter filters = FilterCharacter(name: "", page: 1);
  return filters;
});

/// Provider to get the list of characters
final charactersProvider = FutureProvider.autoDispose<void>((ref) async {
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
      ref.read(noMoreDataProvider.notifier).update((state) => true);

      ref
          .read(filterCharacterProvider.notifier)
          .update((state) => FilterCharacter(
                name: filters.name,
                page: currentPage,
              ));
    }
    ref.read(noMoreDataProvider.notifier).update((state) => false);

    CharacterModel characterList = characterModelFromJson(resp);

    /// case when init
    if (filters.page == 1 ||
        (currentPage == filters.page &&
            filters.page != characterList.info.pages)) {
      ref.read(currentPageProvider.notifier).update((state) => 1);
      ref
          .read(characterListProvider.notifier)
          .update((state) => characterList.character);

      /// case when user change page
    } else if (currentPage < characterList.info.pages) {
      List<Character> list = ref.read(characterListProvider);
      list.addAll(characterList.character);
      ref.read(characterListProvider.notifier).update((state) => list);
      ref.read(currentPageProvider.notifier).update((state) => currentPage + 1);
    }

    /// case when there are not more data
  } else {
    ref.read(characterListProvider.notifier).update((state) => []);
  }
});

/// provider to get list of characters
final characterListProvider = StateProvider<List<Character>>((ref) {
  return [];
});

final currentPageProvider = StateProvider<int>((ref) {
  return 1;
});

final noMoreDataProvider = StateProvider<bool>((ref) {
  return false;
});

final characterSelectedProvider = StateProvider<Character?>((ref) {
  return null;
});

/// Provider to get origin from any character
/// Spects an url
final getOriginProvider =
    FutureProvider.autoDispose.family<LocationModel?, String>((ref, url) async {
  if (url == "") {
    return null;
  }

  Uri uri = Uri.parse(url);
  String lastPathSegment = uri.pathSegments.last;

  String? resp = await BaseHttpService.baseGet(
      url: "$getLocation/$lastPathSegment", params: {});

  if (resp != null) {
    LocationModel location = locationModelFromJson(resp);

    return location;
  } else {
    return null;
  }
});

/// Provider to get location from any character
/// Spects an url
final getLocationProvider =
    FutureProvider.autoDispose.family<LocationModel?, String>((ref, url) async {
  if (url == "") {
    return null;
  }
  Uri uri = Uri.parse(url);
  String lastPathSegment = uri.pathSegments.last;

  String? resp = await BaseHttpService.baseGet(
      url: "$getLocation/$lastPathSegment", params: {});

  if (resp != null) {
    LocationModel location = locationModelFromJson(resp);

    return location;
  } else {
    return null;
  }
});
