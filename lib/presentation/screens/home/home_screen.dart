// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
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

    if (loadingMorePost) {
      ref.read(filterCharacterProvider.notifier).update(
          (state) => FilterCharacter(name: filters.name, page: state.page + 1));
      ref.refresh(charactersProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final characteres = ref.watch(charactersProvider);
    final characteresList = ref.watch(characterListProvider);
    final filters = ref.watch(filterCharacterProvider);

    return Scaffold(
      backgroundColor: ColorStyle.blackSecondaryColor,
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SearchFieldWidget(
                ctx: context,
                onTyping: (type) {
                  final newFilter = FilterCharacter(
                    name: type,
                    page: 1,
                  );

                  ref
                      .read(filterCharacterProvider.notifier)
                      .update((state) => newFilter);
                },
                controller: controller,
              )),
          Expanded(
            flex: 10,
            child: characteres.when(
              data: (data) {
                if (characteresList.isEmpty) {
                  setState(() {
                    loadingMorePost = false;
                  });
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/animations/search.json",
                            height: 220, fit: BoxFit.contain),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "No se encontraron personajes.",
                          style: TxtStyle.labelStyle.copyWith(fontSize: 7.sp),
                        ),
                      ],
                    ),
                  );
                } else {
                  setState(() {
                    loadingMorePost = true;
                  });
                }

                return RefreshIndicator(
                  backgroundColor: ColorStyle.whiteBackground,
                  color: ColorStyle.primaryColor,
                  onRefresh: () async {
                    ref.read(filterCharacterProvider.notifier).update((state) =>
                        FilterCharacter(name: filters.name, page: 1));
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
                          return (characteresList.isNotEmpty)
                              ? (characteresList.length > 10)
                                  ? Column(
                                      children: [
                                        LoadingStandardWidget.loadingWidget(),
                                        Text(
                                          "Cargando más personajes",
                                          style: TxtStyle.labelStyle,
                                        )
                                      ],
                                    )
                                  : const SizedBox()
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      "No hay más personajes por cargar.",
                                      style: TxtStyle.labelStyle,
                                    ),
                                  ),
                                );
                        }
                      }),
                );
              },
              error: (error, stackTrace) =>
                  LoadingStandardWidget.loadingErrorWidget(),
              loading: () => LoadingStandardWidget.loadingWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
