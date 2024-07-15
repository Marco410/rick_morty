// ignore_for_file: unused_result

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:rick_morty/presentation/widgets/search_field_widget.dart';
import 'package:sizer_pro/sizer.dart';

import '../../models/models.dart';
import '../../providers/home/characteres_provider.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final _scrollController = ScrollController();
  double scrollPosition = 0;
  bool loadMore = false;
  bool loadingMorePost = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        scrollPosition = _scrollController.offset;
      });
      if (_scrollController.position.maxScrollExtent ==
          (_scrollController.offset)) {
        fetchData();
      }
    });
  }

  Future fetchData() async {
    final filters = ref.read(filterCharacterProvider);

    ref.read(filterCharacterProvider.notifier).update(
        (state) => FilterCharacter(name: filters.name, page: state.page + 1));
    ref.refresh(charactersProvider);
    _scrollController.animateTo(scrollPosition,
        duration: const Duration(milliseconds: 600), curve: Curves.ease);
  }

  void scrollTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 600), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(charactersProvider);
    final noMoreData = ref.watch(noMoreDataProvider);
    final characteresList = ref.watch(characterListProvider);
    final filters = ref.watch(filterCharacterProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorStyle.blackSecondaryColor,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (scrollPosition > 200)
                ? FadedScaleAnimation(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      highlightColor: ColorStyle.whiteBackground,
                      onTap: () => scrollTop(),
                      child: Container(
                        height: 20.sp,
                        width: 20.sp,
                        decoration: BoxDecoration(
                            color: ColorStyle.primaryColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        body: Column(
          children: [
            SearchFieldWidget(
              ctx: context,
              onTyping: (type) {
                ref
                    .read(filterCharacterProvider.notifier)
                    .update((state) => FilterCharacter(
                          name: type,
                          page: 1,
                        ));
              },
              controller: controller,
            ),
            Expanded(
              flex: 10,
              child: RefreshIndicator(
                backgroundColor: ColorStyle.whiteBackground,
                color: ColorStyle.primaryColor,
                onRefresh: () async {
                  ref.read(filterCharacterProvider.notifier).update(
                      (state) => FilterCharacter(name: filters.name, page: 1));
                  ref.refresh(charactersProvider);
                },
                child: ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: characteresList.length + 1,
                    controller: _scrollController,
                    itemBuilder: (BuildContext ctx, index) {
                      if (index < characteresList.length) {
                        return CharacterWidget(
                            character: characteresList[index]);
                      } else {
                        return (characteresList.length > 10)
                            ? (!noMoreData)
                                ? LoadingStandardWidget.loadingWidget()
                                : const SizedBox()
                            : const SizedBox();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
