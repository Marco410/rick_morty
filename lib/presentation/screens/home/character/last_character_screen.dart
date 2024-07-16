// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

import '../../../controllers/character_controller.dart';
import '../../../models/models.dart';
import '../../../providers/home/characteres_provider.dart';
import '../../../widgets/widgets.dart';

class LastCharacterScreen extends ConsumerStatefulWidget {
  const LastCharacterScreen({super.key});

  @override
  ConsumerState<LastCharacterScreen> createState() =>
      _LastCharacterScreenState();
}

class _LastCharacterScreenState extends ConsumerState<LastCharacterScreen> {
  List<Character> listCharacters = [];
  Character? character;
  @override
  void initState() {
    super.initState();
    getLastViews();
  }

  getLastViews() async {
    final characters = await CharacterController.getCharactersViews();

    setState(() {
      listCharacters.addAll(characters.map((e) => Character(
            id: e["character_id"],
            name: e["name"],
            status: statusValues.map[e['status']]!,
            species: e['species'],
            type: e['type'],
            gender: e['gender'],
            image: e['image'],
            origin: Location(name: e['originName'], url: e['originUrl']),
            location: Location(name: e['locationName'], url: e['locationUrl']),
          )));

      character = listCharacters.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.blackSecondaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Último personaje visto.",
              style: TxtStyle.headerStyle.copyWith(fontSize: 9.sp),
            ),
          ),
          (listCharacters.isNotEmpty && character != null)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(characterSelectedProvider.notifier)
                          .update((state) => character);
                      context.pushNamed("character_detail");
                    },
                    child: CharacterWidget(
                      character: character!,
                      vertical: true,
                    ),
                  ),
                )
              : Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/animations/not_found.json',
                              height: 250),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "No has visto ningún personaje recientemente.",
                            textAlign: TextAlign.center,
                            style: TxtStyle.labelStyle.copyWith(
                                color: ColorStyle.secondaryColor,
                                fontSize: 7.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
