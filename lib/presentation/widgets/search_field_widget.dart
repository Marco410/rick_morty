import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

// ignore: must_be_immutable
class SearchFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function? onTyping;
  final BuildContext ctx;

  const SearchFieldWidget({
    super.key,
    required this.controller,
    required this.ctx,
    required this.onTyping,
  });

  @override
  Widget build(BuildContext context) {
    return FadedScaleAnimation(
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        padding: const EdgeInsets.only(left: 20, right: 10, top: 0, bottom: 0),
        decoration: BoxDecoration(
            color: ColorStyle.blackColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12.withOpacity(0.1),
                  spreadRadius: -3.0)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onTyping as void Function(String)?,
                keyboardType: TextInputType.text,
                autocorrect: false,
                textInputAction: TextInputAction.go,
                style: TextStyle(
                    color: ColorStyle.whiteBackground, fontSize: 4.5.sp),
                onEditingComplete: () {
                  FocusScope.of(ctx).unfocus();
                },
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Buscar...",
                    hintStyle: TxtStyle.labelStyle,
                    enabledBorder: InputBorder.none,
                    suffixStyle: TxtStyle.labelStyle,
                    focusColor: ColorStyle.whiteBackground),
              ),
            ),
            FadedScaleAnimation(
              child: InkWell(
                onTap: () {
                  if (FocusScope.of(ctx).hasPrimaryFocus) {
                    FocusScope.of(ctx).unfocus();
                  }
                  FocusScope.of(ctx).requestFocus();
                },
                child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorStyle.primaryColor.withOpacity(0.1)),
                    child: Icon(
                      Icons.search_rounded,
                      color: ColorStyle.primaryColor,
                      size: 9.sp,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
