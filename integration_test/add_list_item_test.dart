import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:listwhatever/app/view/app.dart';

import 'package:listwhatever/auth/auth_repository.dart';
import 'package:listwhatever/auth/bloc/auth_bloc.dart';
import 'package:listwhatever/auth/models/authentication_user.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/list/repository/list_item_repository.dart';
import 'package:listwhatever/pages/lists/bloc/lists_bloc.dart';
import 'package:listwhatever/pages/lists/components/add_list_form.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';
import 'package:listwhatever/pages/lists/models/user_list.dart';
import 'package:listwhatever/pages/lists/repository/list_repository.dart';
import 'package:listwhatever/pages/lists/repository/user_list_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserListRepository extends Mock implements UserListRepository {}

class MockListRepository extends Mock implements ListRepository {}

class MockListItemRepository extends Mock implements ListItemRepository {}

class MockUser extends Mock implements User {}

class MockUserList extends Mock implements UserList {}

class MockListOfThings extends Mock implements ListOfThings {}

class MockListItem extends Mock implements ListItem {}

class MockAuthenticationUser extends Mock implements AuthenticationUser {}

class MockListBloc extends MockBloc<ListEvent, ListState> implements ListBloc {}

class MockListsBloc extends MockBloc<ListsEvent, ListsState> implements ListsBloc {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    late MockData mockData;

    setUpAll(() {
      registerFallbackValue(MockUserList());
      registerFallbackValue(MockListOfThings());
      registerFallbackValue(MockListItem());
    });

    setUp(() {
      mockData = MockData()..setup();
    });

    testWidgets('verify that right data is tried to be saved', (tester) async {
      // Load app widget.
      final list = ListOfThings(
        id: 'listId1',
        name: 'First list',
        withMap: false,
        withDates: false,
        withTimes: false,
        shared: false,
        sharedWith: {},
        ownerId: 'ownerId',
        createdAt: DateTime.now(),
      );
      final userList = UserList.fromList(list, list.id!);
      when(() => mockData.listBloc.state).thenReturn(ListLoaded(list: list, listItems: []));
      when(() => mockData.listsBloc.state).thenReturn(ListsLoaded([userList]));

      await tester.pumpWidget(
        App(
          authRepository: mockData.authRepository,
          userListRepository: mockData.userListRepository,
          listRepository: mockData.listRepository,
          listItemRepository: mockData.listItemRepository,
          key: const Key('appkey'),
        ),
      );

      when(() => mockData.listRepository.loadList(any())).thenAnswer((_) => Future.value(list));
      when(() => mockData.listItemRepository.loadListItems('listId1')).thenAnswer((_) => Future.value([]));
      when(() => mockData.listItemRepository.addListItem('listId1', any())).thenAnswer((_) => Future.value('itemId'));

      await tester.pump(const Duration(milliseconds: 1500));

      final listButton = find.text('First list');
      expect(listButton, findsOneWidget);
      await tester.tap(listButton);
      await tester.pump(const Duration(milliseconds: 3000));

      // Finds the floating action button to tap on.
      // final actionButton = find.byKey(addListButtonKey);
      final actionButton = find.byType(FloatingActionButton);
      expect(actionButton, findsOneWidget);
      await tester.tap(actionButton);
      await tester.pump(const Duration(milliseconds: 3000));

      final nameTextInput = find.byKey(Key(FieldId.name.value));
      expect(nameTextInput, findsExactly(1));
      await tester.enterText(nameTextInput, 'My New List Item');

      await tester.pump(const Duration(milliseconds: 1000));

      // final scrollableFinder = find.descendant(
      //   of: find.byKey(const Key('addListItemForm')),
      //   matching: find.byType(Scrollable).at(0),
      // );
      // await tester.scrollUntilVisible(
      //   find.byKey(Key(FieldId.submit.value)),
      //   500,
      //   scrollable: scrollableFinder,
      // );
      // await tester.pump(const Duration(milliseconds: 1000));

      final submitButton = find.byKey(Key(FieldId.submit.value));
      expect(submitButton, findsExactly(1));
      await tester.tap(submitButton);
      await tester.pump(const Duration(milliseconds: 1000));

      final capturedList = verify(
        () => mockData.listItemRepository.addListItem('listId1', captureAny()),
      ).captured;

      print('capturedList: $capturedList');

      expect(
        capturedList.last,
        equals(const ListItem(id: null, name: 'My New List Item', info: '')),
      );
    });
  });
}
