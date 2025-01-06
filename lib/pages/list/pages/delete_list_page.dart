import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';
import 'package:listwhatever/routing/routes.dart';

const String className = 'DeleteListPage';

final addListItemFormKey = GlobalKey<FormBuilderState>();

class DeleteListPage extends HookWidget {
  const DeleteListPage({required this.listId, super.key});
  final String listId;

  @override
  Widget build(BuildContext context) {
    useEffect(
      // ignore: body_might_complete_normally_nullable
      () {
        print('DeleteListPage: Calling bloc');
        BlocProvider.of<ListBloc>(context).add(GetList(listId));
      },
      const [],
    );

    final listState = context.watch<ListBloc>().state;
    final isLoading = getLoading(listState);
    final list = getList(listState);

    print('DeleteListPage: listState: $listState');

    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: isLoading ? loadingWidget() : deleteWidget(context, list),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: const Text(/*listItem == null ?*/ 'Delete list' /* : 'Edit item'*/),
      actions: const [],
    );
  }

  bool getLoading(ListState listState) {
    return switch (listState) {
      ListInitial() => true,
      ListLoading() => true,
      ListLoaded() => false,
    };
  }

  ListOfThings? getList(ListState listState) {
    if (listState is ListLoaded) {
      return listState.list;
    }
    return null;
  }

  Widget deleteWidget(BuildContext context, ListOfThings? list) {
    return Column(
      children: [
        Text('Are you sure you want to delete the "${list?.name}" list?'),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('No'),
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ListBloc>().add(DeleteList(listId));
                MainPageRoute().go(context);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ],
    );
  }

  Widget loadingWidget() {
    return const Column(
      children: [CircularProgressIndicator()],
    );
  }
}
