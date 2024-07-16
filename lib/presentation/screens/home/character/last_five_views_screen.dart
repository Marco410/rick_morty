// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

import '../../../controllers/character_controller.dart';
import '../../../models/models.dart';
import '../../../widgets/widgets.dart';

class LastFiveScreen extends ConsumerStatefulWidget {
  const LastFiveScreen({super.key});

  @override
  ConsumerState<LastFiveScreen> createState() => _LastFiveScreenState();
}

class _LastFiveScreenState extends ConsumerState<LastFiveScreen> {
  List<Character> listCharacters = [];
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
              "Vistos recientemente",
              style: TxtStyle.headerStyle,
            ),
          ),
          Expanded(
            flex: 10,
            child: (listCharacters.isNotEmpty)
                ? RefreshIndicator(
                    backgroundColor: ColorStyle.whiteBackground,
                    color: ColorStyle.primaryColor,
                    onRefresh: () async {},
                    child: ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listCharacters.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return CharacterWidget(
                              character: listCharacters[index]);
                        }),
                  )
                : Padding(
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
