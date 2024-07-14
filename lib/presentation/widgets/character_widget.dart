import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:rick_morty/presentation/widgets/loader_image_widget.dart';
import 'package:sizer_pro/sizer.dart';
import '../models/models.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;
  const CharacterWidget({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return FadedScaleAnimation(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: ColorStyle.blackColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 11,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: character.image,
                      fit: BoxFit.contain,
                      width: 70,
                      height: 70,
                      placeholder: (context, url) => const LoaderImageWidget(),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/no-image.png",
                        fit: BoxFit.cover,
                        scale: 1,
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
                          style: TxtStyle.labelStyle.copyWith(fontSize: 7.sp),
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
                                  style: TxtStyle.labelStyle
                                      .copyWith(fontWeight: FontWeight.normal),
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
      ),
    );
  }
}
