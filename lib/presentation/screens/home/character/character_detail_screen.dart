import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:rick_morty/presentation/controllers/character_controller.dart';
import 'package:sizer_pro/sizer.dart';

import '../../../models/models.dart';
import '../../../providers/home/characteres_provider.dart';
import '../../../widgets/loader_image_widget.dart';
import '../../../widgets/widgets.dart';

class CharacterDetail extends ConsumerStatefulWidget {
  const CharacterDetail({super.key});

  @override
  ConsumerState<CharacterDetail> createState() => _CharacterDetailState();
}

class _CharacterDetailState extends ConsumerState<CharacterDetail> {
  @override
  void initState() {
    final character = ref.read(characterSelectedProvider);

    if (character != null) {
      CharacterController.insertViewCharacter(character);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late AsyncValue<LocationModel?> location;
    late AsyncValue<LocationModel?> origin;

    var character = ref.read(characterSelectedProvider);
    if (character != null) {
      origin = ref.watch(getOriginProvider(character.origin.url));
      location = ref.watch(getLocationProvider(character.location.url));
    }

    return Scaffold(
      backgroundColor: ColorStyle.blackSecondaryColor,
      appBar: const AppBarWidget(
        backButton: true,
      ),
      body: (character != null)
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        FadedScaleAnimation(
                          child: Opacity(
                            opacity: 0.4,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(character.image),
                                fit: BoxFit.cover,
                              )),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 50),
                          child: Hero(
                            tag: character.id,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: CachedNetworkImage(
                                imageUrl: character.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) =>
                                    const LoaderImageWidget(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/no-image.png",
                                  fit: BoxFit.cover,
                                  scale: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadedScaleAnimation(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        character.name,
                        style: TxtStyle.headerStyle.copyWith(
                            color: ColorStyle.secondaryColor, fontSize: 11.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: BoxInfoWidget(
                            title: "Estado:",
                            text: character.status.name,
                          ),
                        ),
                        Expanded(
                          child: BoxInfoWidget(
                            title: "Especie:",
                            text: character.species,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: BoxInfoWidget(
                            title: "Tipo:",
                            text: character.species,
                          ),
                        ),
                        Expanded(
                          child: BoxInfoWidget(
                            title: "Género:",
                            text: character.gender,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadedScaleAnimation(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        "Origen:",
                        style: TxtStyle.headerStyle.copyWith(
                            color: ColorStyle.whiteBackground, fontSize: 8.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: origin.when(
                      data: (data) {
                        if (data != null) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: BoxInfoWidget(
                                  title: "Nombre:",
                                  text: character.origin.name,
                                  vertical: true,
                                ),
                              ),
                              Expanded(
                                child: BoxInfoWidget(
                                  title: "Tipo:",
                                  text: data.type,
                                  vertical: true,
                                ),
                              ),
                              Expanded(
                                child: BoxInfoWidget(
                                  title: "Dimension:",
                                  text: data.dimension,
                                  vertical: true,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: BoxInfoWidget(
                              title: "Nombre:",
                              text: character.origin.name,
                              vertical: true,
                            ),
                          );
                        }
                      },
                      error: (error, stackTrace) =>
                          LoadingStandardWidget.loadingErrorWidget(),
                      loading: () => LoadingStandardWidget.loadingWidget(),
                    ),
                  ),
                  FadedScaleAnimation(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        "Ubicación:",
                        style: TxtStyle.headerStyle.copyWith(
                            color: ColorStyle.whiteBackground, fontSize: 8.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: location.when(
                      data: (data) {
                        if (data != null) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: BoxInfoWidget(
                                  title: "Nombre:",
                                  text: character.location.name,
                                  vertical: true,
                                ),
                              ),
                              Expanded(
                                child: BoxInfoWidget(
                                  title: "Tipo:",
                                  text: data.type,
                                  vertical: true,
                                ),
                              ),
                              Expanded(
                                child: BoxInfoWidget(
                                  title: "Dimension:",
                                  text: data.dimension,
                                  vertical: true,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: BoxInfoWidget(
                              title: "Nombre:",
                              text: character.location.name,
                              vertical: true,
                            ),
                          );
                        }
                      },
                      error: (error, stackTrace) =>
                          LoadingStandardWidget.loadingErrorWidget(),
                      loading: () => LoadingStandardWidget.loadingWidget(),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          : Center(child: LoadingStandardWidget.loadingWidget()),
    );
  }
}

class BoxInfoWidget extends StatelessWidget {
  const BoxInfoWidget(
      {super.key,
      required this.title,
      required this.text,
      this.vertical = false});

  final String title;
  final String text;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: Container(
          width: (vertical) ? 120 : 180,
          height: (vertical) ? 150 : 90,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: ColorStyle.whiteBackground),
              color: ColorStyle.blackColor,
              boxShadow: [ShadowStyle.containerShadow],
              borderRadius: BorderRadius.circular(20)),
          child: (!vertical)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TxtStyle.labelStyle,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      text,
                      style: TxtStyle.labelStyle.copyWith(
                          color: ColorStyle.primaryColor, fontSize: 5.6.sp),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TxtStyle.labelStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TxtStyle.labelStyle.copyWith(
                          color: ColorStyle.secondaryColor, fontSize: 5.6.sp),
                    )
                  ],
                )),
    );
  }
}
