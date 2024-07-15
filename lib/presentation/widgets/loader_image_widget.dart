import 'package:flutter/material.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:shimmer/shimmer.dart';

class LoaderImageWidget extends StatelessWidget {
  const LoaderImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Shimmer.fromColors(
          baseColor: ColorStyle.primaryColor,
          highlightColor: ColorStyle.primaryColor.withOpacity(0.2),
          child: Container(
            width: 50,
            height: 50,
            color: Colors.grey,
          ),
        ),
        const Icon(
          Icons.image_rounded,
          color: ColorStyle.whiteBackground,
        )
      ],
    );
  }
}
