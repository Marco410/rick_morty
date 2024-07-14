import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer_pro/sizer.dart';
import '../../config/theme/style.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  const AppBarWidget({
    this.backButton = false,
    super.key,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  final double _prefferedHeight = 45;

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorStyle.blackColor,
      elevation: 0,
      leading: (widget.backButton)
          ? InkWell(
              onTap: () => context.pop(),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: ColorStyle.primaryColor,
                size: 26,
              ),
            )
          : const SizedBox(),
      title: SvgPicture.asset("assets/logo.svg", height: 12.sp),
    );
  }
}
