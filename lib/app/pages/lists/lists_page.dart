import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listanything/app/common_theme_data.dart';
import 'package:listanything/app/helpers/constants.dart';
import 'package:listanything/app/navigation/routes/add_list_route.dart';
import 'package:listanything/app/navigation/routes/list_items_page_route.dart';
import 'package:listanything/app/navigation/routes/routes.dart';
import 'package:listanything/app/navigation/routes/share_code_page_route.dart';
import 'package:listanything/app/pages/lists/list_of_things.dart';
import 'package:listanything/app/pages/lists/lists_provider.dart';
import 'package:listanything/app/widgets/standardWidgets/app_bar_action.dart';
import 'package:listanything/app/widgets/standardWidgets/common_drawer.dart';
import 'package:listanything/app/widgets/standardWidgets/common_scaffold.dart';
import 'package:listanything/app/widgets/standardWidgets/exception_widget.dart';
import 'package:listanything/app/widgets/standardWidgets/image_button.dart';
import 'package:listanything/app/widgets/standardWidgets/shimmer.dart';
import 'package:listanything/app/widgets/standardWidgets/shimmer_loading.dart';

const images = {
  ListType.restaurants: 'assets/images/restaurants.jpeg',
  ListType.food: 'assets/images/food.webp',
  ListType.movies: 'assets/images/movies.webp',
  ListType.activities: 'assets/images/activities.png',
};

class ListsPage extends ConsumerWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(combinedListsProvider).when(
          error: (e, st) => ExceptionWidget(e: e, st: st),
          loading: () => ListsPageInner(
            lists: List.generate(
              8,
              (index) => const ListOfThings(
                name: '',
                userId: 'Not used since a shimmer',
                type: ListType.other,
              ),
            ),
            isLoading: true,
          ),
          data: (lists) => ListsPageInner(lists: lists, isLoading: false),
        );
  }
}

class ListsPageInner extends ConsumerWidget {
  const ListsPageInner({
    required this.lists,
    required this.isLoading,
    super.key,
  });

  final List<ListOfThings> lists;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.d('screen size: ${MediaQuery.of(context).size.width}');
    final crossAxisCount =
        kIsWeb ? (MediaQuery.of(context).size.width / 350).floor() : 2;
    return CommonScaffold(
      drawer: const Drawer(child: CommonDrawer()),
      title: 'Lists',
      actions: [
        AppBarAction(
          key: const Key('newitem'),
          title: 'New item',
          icon: Icons.playlist_add_outlined,
          callback: () => addNewList(ref, context),
          overflow: false,
        ),
        AppBarAction(
          key: const Key('sharecodedialog'),
          title: 'Go to share code',
          icon: Icons.add_card,
          callback: () => shareCodeDialog(context),
          overflow: true,
        ),
      ],
      body: Shimmer(
        linearGradient: shimmerGradient,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomScrollView(
            slivers: [
              SliverGrid.count(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: crossAxisCount,
                children: lists
                    .map(
                      (list) => ImageButton<ListOfThings>(
                        item: list,
                        image: images[list.type] ?? 'assets/images/generic.jpg',
                        text: list.name,
                        callback: (list) => selectList(ref, context, list),
                        isLoading: isLoading,
                        topRightIcon: list.shared
                            ? const Icon(
                                Icons.supervised_user_circle,
                                color: mainColor,
                              )
                            : const Icon(
                                Icons.verified_user_outlined,
                                color: mainColor,
                              ),
                        topRightIconBorderColor: list.shared
                            ? secondaryButtonColor
                            : primaryButtonColor,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectList(WidgetRef ref, BuildContext context, ListOfThings list) {
    // ref.read(selectedListIdProvider.notifier).state = list.publicListId;
    logger.d('clicking ${list.publicListId}');
    ListItemsPageRoute(publicListId: list.publicListId!).push<void>(context);
    logger.d('lists_page.selectList: $list');
  }

  Future<void> addNewList(WidgetRef ref, BuildContext context) async {
    await const AddListRoute().push<void>(context);
  }

  Future<void> shareCodeDialog(BuildContext context) async {
    final publicListIdController = TextEditingController(text: '');
    final shareCodeController = TextEditingController(text: '');
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('TextField in Dialog'),
          content: Column(
            children: [
              TextField(
                controller: publicListIdController,
                decoration: const InputDecoration(hintText: 'Public list id'),
              ),
              TextField(
                controller: shareCodeController,
                decoration: const InputDecoration(hintText: 'Share code'),
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: const Text('OK'),
              onPressed: () {
                ShareCodePageRoute(
                  publicListId: publicListIdController.value.text,
                  shareCode: shareCodeController.value.text,
                ).go(context);
              },
            ),
          ],
        );
      },
    );
  }
}
