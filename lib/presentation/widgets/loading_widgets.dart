import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty/config/theme/style.dart';

class LoadingStandardWidget {
  static Widget loadingWidget() {
    return Center(
      child: LoadingAnimationWidget.dotsTriangle(
        color: ColorStyle.primaryColor,
        size: 40,
      ),
    );
  }

  static Widget loadingErrorWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              "https://lottie.host/0f5bfd78-9ea4-4ab3-921f-c58d3efaf57e/8oUUsRf8Ry.json",
              height: 100,
              fit: BoxFit.contain),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Estamos teniendo algunos problemas. \n Por favor intente más tarde.",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
