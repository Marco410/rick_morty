import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:rick_morty/presentation/widgets/loader_image_widget.dart';
import 'package:sizer_pro/sizer.dart';
import '../models/models.dart';

class CharacterWidget extends ConsumerWidget {
  final Character character;
  final bool vertical;
  const CharacterWidget(
      {super.key, required this.character, this.vertical = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FadedScaleAnimation(
      child: (vertical)
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50.h,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  margin: const EdgeInsets.only(top: 10, bottom: 0),
                  decoration: BoxDecoration(
                      color: ColorStyle.blackColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: character.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: character.image,
                            fit: BoxFit.contain,
                            width: 300,
                            height: 300,
                            placeholder: (context, url) =>
                                const LoaderImageWidget(),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/no-image.png",
                              fit: BoxFit.cover,
                              scale: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        character.name,
                        style: TxtStyle.labelStyle.copyWith(fontSize: 11.sp),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text.rich(
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                            text: 'Especie: ',
                            style: TxtStyle.labelStyle.copyWith(
                                fontWeight: FontWeight.normal, fontSize: 7.sp),
                            children: [
                              TextSpan(
                                text: character.species,
                                style: TxtStyle.labelStyle.copyWith(
                                    color: ColorStyle.primaryColor,
                                    fontSize: 7.sp),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: ColorStyle.blackColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Text(
                    character.status.name,
                    style: TxtStyle.labelStyle.copyWith(
                        fontSize: 7.sp,
                        color: character.status == Status.alive
                            ? Colors.greenAccent
                            : (character.status == Status.dead)
                                ? Colors.redAccent
                                : Colors.amberAccent),
                  ),
                )
              ],
            )
          : HorizontalViewWidget(character: character),
    );
  }
}

class HorizontalViewWidget extends StatelessWidget {
  const HorizontalViewWidget({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: ColorStyle.blackColor,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 11,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Hero(
                          tag: character.id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: character.image,
                              fit: BoxFit.contain,
                              width: 70,
                              height: 70,
                              placeholder: (context, url) =>
                                  const LoaderImageWidget(),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/no-image.png",
                                fit: BoxFit.cover,
                                scale: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name,
                                style: TxtStyle.labelStyle
                                    .copyWith(fontSize: 7.sp),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text.rich(
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    TextSpan(
                                        text: 'Especie: ',
                                        style: TxtStyle.labelStyle.copyWith(
                                            fontWeight: FontWeight.normal),
                                        children: [
                                          TextSpan(
                                            text: character.species,
                                            style: TxtStyle.labelStyle.copyWith(
                                                color: ColorStyle.primaryColor),
                                          ),
                                        ]),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorStyle.primaryColor,
                      ))
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 50, right: 50),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: ColorStyle.blackColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Text(
            character.status.name,
            style: TxtStyle.labelStyle.copyWith(
                color: character.status == Status.alive
                    ? Colors.greenAccent
                    : (character.status == Status.dead)
                        ? Colors.redAccent
                        : Colors.amberAccent),
          ),
        )
      ],
    );
  }
}
