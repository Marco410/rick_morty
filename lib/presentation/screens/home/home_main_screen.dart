import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:rick_morty/presentation/providers/providers.dart';

import '../../widgets/widgets.dart';

class HomeMainScreen extends ConsumerStatefulWidget {
  const HomeMainScreen({super.key});

  @override
  ConsumerState<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends ConsumerState<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    final bodyAsync = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: ColorStyle.blackSecondaryColor,
      appBar: const AppBarWidget(),
      body: bodyAsync.when(
          data: (widgetBody) => widgetBody,
          error: (_, __) =>
              Center(child: LoadingStandardWidget.loadingErrorWidget()),
          loading: () => Container(
                margin: const EdgeInsets.only(top: 50),
                child: LoadingStandardWidget.loadingWidget(),
              )),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: ColorStyle.blackSecondaryColor,
        color: ColorStyle.blackColor,
        buttonBackgroundColor: ColorStyle.primaryColor,
        animationDuration: const Duration(milliseconds: 200),
        index: 1,
        items: const <Widget>[
          Icon(
            Icons.person_2_rounded,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.home_filled,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.people_alt_rounded,
            size: 26,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          ref.read(currentIndexPage.notifier).update((state) => index);
        },
      ),
    );
  }
}
