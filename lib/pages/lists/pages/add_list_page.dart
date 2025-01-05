import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/auth/bloc/auth_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/lists/bloc/lists_bloc.dart';
import 'package:listwhatever/pages/lists/components/add_list_form.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

class AddListPage extends StatefulWidget {
  const AddListPage({super.key});

  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListsBloc>(context).add(const ListsEvent.watchUserLists());
    // BlocProvider.of<FirebaseStorageBloc>(context)
    //     .add(const FirebaseStorageEvent.getAllUserLists());
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<AuthBloc>().state;
    final userId = getUserId(userState);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add list'),
      ),
      body: AddListForm(
        userId: userId,
        list: null,
        isLoading: userId == null,
        save: save,
      ),
    );
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
      id: null, //widget.listId,
      name: values[FieldId.name.value]! as String,
      // imageFilename: imageFilename,
      withMap: values[FieldId.withMap.value] as bool,
      withDates: values[FieldId.withDates.value] as bool,
      withTimes: values[FieldId.withTimes.value] as bool,
      shared: false, //values[AddListValues.share.toString()] as bool,
      // shareCodeForViewer: null,
      // shareCodeForEditor: null,
      sharedWith: {},
      ownerId: userId,
      // filterTypes: filterTypes,
      createdAt: DateTime.now(),
    );
    // LoggerHelper.logger.d('newList: $newList');
    // if (widget.listId == null) {
    listBloc.add(AddList(newList));
    // } else {
    //   listCrudBloc.add(UpdateList(newList));
    // }
    // LoggerHelper.logger.i('$className -> popping once');
    goRouter.pop();
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
}
