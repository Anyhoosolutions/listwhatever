import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/auth/bloc/auth_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/lists/components/add_list_form.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

class EditListPage extends StatefulWidget {
  const EditListPage({required this.listId, super.key});
  final String listId;

  @override
  State<EditListPage> createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListBloc>(context).add(GetList(widget.listId));
    // BlocProvider.of<FirebaseStorageBloc>(context)
    //     .add(const FirebaseStorageEvent.getAllUserLists());
  }

  @override
  Widget build(BuildContext context) {
    final listState = context.watch<ListBloc>().state;
    final userState = context.watch<AuthBloc>().state;

    final userId = getUserId(userState);
    final isLoading = getIsLoading(listState, userId);
    final list = getList(listState);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit list'),
      ),
      body: AddListForm(
        list: list,
        save: save,
        userId: userId,
        isLoading: isLoading,
      ),
    );
  }

  String? getUserId(AuthState userState) {
    if (userState is AuthLoggedInWithData) {
      return userState.user.uid;
    } else if (userState is AuthOnboardingRequired) {
      return userState.user.id;
    } else if (userState is AuthLoggedIn) {
      return userState.user.id;
    } else {
      return null;
    }
  }

  bool getIsLoading(ListState listState, String? userId) {
    if (userId == null) {
      return true;
    }
    return listState is! ListLoaded;
  }

  ListOfThings? getList(ListState listState) {
    if (listState is ListLoaded) {
      return listState.list;
    }
    return null;
  }

  Future<void> save(
    BuildContext context,
    ListOfThings? list,
    Map<String, dynamic> values,
    String userId,
  ) async {
    final listBloc = BlocProvider.of<ListBloc>(context);
    final goRouter = GoRouter.of(context);

    // String? imageFilename;
    // if (values.containsKey(FieldId.listTypeImage.value)) {
    //   imageFilename = await uploadImage(values[FieldId.listTypeImage.value] as List);
    //   // LoggerHelper.logger.i('$className: imageFilename: $imageFilename');
    // }

    // final filterTypes = getFilterTypes(values);
    // // LoggerHelper.logger.d('values: $values');
    final newList = ListOfThings(
      id: widget.listId,
      name: values[FieldId.name.value]! as String,
      // imageFilename: imageFilename,
      withMap: values[FieldId.withMap.value] as bool,
      withDates: values[FieldId.withDates.value] as bool,
      withTimes: values[FieldId.withTimes.value] as bool,
      shared: false, //values[AddListValues.share.toString()] as bool,
      // shareCodeForViewer: null,
      // shareCodeForEditor: null,
      sharedWith: {},
      ownerId: list?.ownerId,
      // filterTypes: filterTypes,
    );
    listBloc.add(EditList(newList));
    goRouter.pop();
  }
}
