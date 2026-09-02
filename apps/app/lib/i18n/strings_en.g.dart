///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'List Whatever'
	String get appName => 'List Whatever';

	/// en: 'Staging'
	String get staging => 'Staging';

	/// en: 'Loading...'
	String get genericLoading => 'Loading...';

	/// en: 'No data'
	String get genericNoData => 'No data';

	/// en: 'Error'
	String get genericError => 'Error';

	/// en: 'and'
	String get listConjunction => 'and';

	late final Translations$appShell$en appShell = Translations$appShell$en._(_root);
	late final Translations$mainPage$en mainPage = Translations$mainPage$en._(_root);
	late final Translations$homePage$en homePage = Translations$homePage$en._(_root);
	late final Translations$listItemsPage$en listItemsPage = Translations$listItemsPage$en._(_root);
	late final Translations$addItemPage$en addItemPage = Translations$addItemPage$en._(_root);
	late final Translations$newListPage$en newListPage = Translations$newListPage$en._(_root);
	late final Translations$itemPage$en itemPage = Translations$itemPage$en._(_root);
	late final Translations$settingsPage$en settingsPage = Translations$settingsPage$en._(_root);
}

// Path: appShell
class Translations$appShell$en {
	Translations$appShell$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$appShell$menu$en menu = Translations$appShell$menu$en._(_root);
}

// Path: mainPage
class Translations$mainPage$en {
	Translations$mainPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get homeTab => 'Home';

	/// en: 'Counter'
	String get counterTab => 'Counter';

	/// en: 'Settings'
	String get settingsTab => 'Settings';
}

// Path: homePage
class Translations$homePage$en {
	Translations$homePage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Lists'
	String get header => 'My Lists';

	/// en: 'Search lists...'
	String get searchHint => 'Search lists...';

	/// en: '$n items'
	String itemCount({required Object n}) => '${n} items';

	/// en: 'No lists match your filters'
	String get empty => 'No lists match your filters';

	/// en: 'Favorite Cafes'
	String get featuredTitle => 'Favorite Cafes';

	/// en: '7 locations tagged.'
	String get featuredSubtitle => '7 locations tagged.';

	/// en: 'Map view enabled.'
	String get featuredBadge => 'Map view enabled.';
}

// Path: listItemsPage
class Translations$listItemsPage$en {
	Translations$listItemsPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'List'
	String get listTab => 'List';

	/// en: 'Map'
	String get mapTab => 'Map';

	/// en: 'Search courses, locations...'
	String get searchHint => 'Search courses, locations...';

	/// en: 'No items match your search'
	String get empty => 'No items match your search';

	/// en: 'Public'
	String get accessPublic => 'Public';

	/// en: 'Private'
	String get accessPrivate => 'Private';

	/// en: '$access · PAR $par'
	String metaLine({required Object access, required Object par}) => '${access} · PAR ${par}';

	/// en: '$rating · $location'
	String ratingLine({required Object rating, required Object location}) => '${rating} · ${location}';

	/// en: 'Directions'
	String get directions => 'Directions';
}

// Path: addItemPage
class Translations$addItemPage$en {
	Translations$addItemPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Item Name'
	String get itemNameLabel => 'Item Name';

	/// en: 'Enter item name...'
	String get itemNameHint => 'Enter item name...';

	/// en: 'Description'
	String get descriptionLabel => 'Description';

	/// en: 'Add details...'
	String get descriptionHint => 'Add details...';

	/// en: 'Categories'
	String get categoriesTitle => 'Categories';

	/// en: 'Add custom attributes like Genre or Status.'
	String get categoriesSubtitle => 'Add custom attributes like Genre or Status.';

	/// en: 'Attribute (e.g. Genre)'
	String get attributeKeyHint => 'Attribute (e.g. Genre)';

	/// en: 'Value (e.g. Drama)'
	String get attributeValueHint => 'Value (e.g. Drama)';

	/// en: 'Add New Category'
	String get addCategory => 'Add New Category';

	/// en: 'Location'
	String get locationTitle => 'Location';

	/// en: 'Tap to set'
	String get tapToSet => 'Tap to set';

	/// en: 'Latitude'
	String get latitudeLabel => 'Latitude';

	/// en: '34.0522° N'
	String get latitudeHint => '34.0522° N';

	/// en: 'Use the format 34.0522° N'
	String get latitudeInvalid => 'Use the format 34.0522° N';

	/// en: 'Longitude'
	String get longitudeLabel => 'Longitude';

	/// en: '118.2437° W'
	String get longitudeHint => '118.2437° W';

	/// en: 'Use My Current Location'
	String get useCurrentLocation => 'Use My Current Location';

	/// en: 'Create Item'
	String get createItem => 'Create Item';
}

// Path: newListPage
class Translations$newListPage$en {
	Translations$newListPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'List Preview'
	String get previewLabel => 'List Preview';

	/// en: 'List Name'
	String get nameLabel => 'List Name';

	/// en: 'e.g., Summer Road Trip 2024'
	String get nameHint => 'e.g., Summer Road Trip 2024';

	/// en: 'Choose an Icon'
	String get iconLabel => 'Choose an Icon';

	/// en: 'Theme Color'
	String get themeColorLabel => 'Theme Color';

	/// en: 'Enable Map View'
	String get enableMapView => 'Enable Map View';

	/// en: 'Share with Friends'
	String get shareWithFriends => 'Share with Friends';

	/// en: 'Create List'
	String get createList => 'Create List';
}

// Path: itemPage
class Translations$itemPage$en {
	Translations$itemPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Refresh'
	String get refreshButton => 'Refresh';
}

// Path: settingsPage
class Translations$settingsPage$en {
	Translations$settingsPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get header => 'Settings';
}

// Path: appShell.menu
class Translations$appShell$menu$en {
	Translations$appShell$menu$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'Logout'
	String get logout => 'Logout';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'List Whatever',
			'staging' => 'Staging',
			'genericLoading' => 'Loading...',
			'genericNoData' => 'No data',
			'genericError' => 'Error',
			'listConjunction' => 'and',
			'appShell.menu.settings' => 'Settings',
			'appShell.menu.profile' => 'Profile',
			'appShell.menu.logout' => 'Logout',
			'mainPage.homeTab' => 'Home',
			'mainPage.counterTab' => 'Counter',
			'mainPage.settingsTab' => 'Settings',
			'homePage.header' => 'My Lists',
			'homePage.searchHint' => 'Search lists...',
			'homePage.itemCount' => ({required Object n}) => '${n} items',
			'homePage.empty' => 'No lists match your filters',
			'homePage.featuredTitle' => 'Favorite Cafes',
			'homePage.featuredSubtitle' => '7 locations tagged.',
			'homePage.featuredBadge' => 'Map view enabled.',
			'listItemsPage.listTab' => 'List',
			'listItemsPage.mapTab' => 'Map',
			'listItemsPage.searchHint' => 'Search courses, locations...',
			'listItemsPage.empty' => 'No items match your search',
			'listItemsPage.accessPublic' => 'Public',
			'listItemsPage.accessPrivate' => 'Private',
			'listItemsPage.metaLine' => ({required Object access, required Object par}) => '${access} · PAR ${par}',
			'listItemsPage.ratingLine' => ({required Object rating, required Object location}) => '${rating} · ${location}',
			'listItemsPage.directions' => 'Directions',
			'addItemPage.itemNameLabel' => 'Item Name',
			'addItemPage.itemNameHint' => 'Enter item name...',
			'addItemPage.descriptionLabel' => 'Description',
			'addItemPage.descriptionHint' => 'Add details...',
			'addItemPage.categoriesTitle' => 'Categories',
			'addItemPage.categoriesSubtitle' => 'Add custom attributes like Genre or Status.',
			'addItemPage.attributeKeyHint' => 'Attribute (e.g. Genre)',
			'addItemPage.attributeValueHint' => 'Value (e.g. Drama)',
			'addItemPage.addCategory' => 'Add New Category',
			'addItemPage.locationTitle' => 'Location',
			'addItemPage.tapToSet' => 'Tap to set',
			'addItemPage.latitudeLabel' => 'Latitude',
			'addItemPage.latitudeHint' => '34.0522° N',
			'addItemPage.latitudeInvalid' => 'Use the format 34.0522° N',
			'addItemPage.longitudeLabel' => 'Longitude',
			'addItemPage.longitudeHint' => '118.2437° W',
			'addItemPage.useCurrentLocation' => 'Use My Current Location',
			'addItemPage.createItem' => 'Create Item',
			'newListPage.previewLabel' => 'List Preview',
			'newListPage.nameLabel' => 'List Name',
			'newListPage.nameHint' => 'e.g., Summer Road Trip 2024',
			'newListPage.iconLabel' => 'Choose an Icon',
			'newListPage.themeColorLabel' => 'Theme Color',
			'newListPage.enableMapView' => 'Enable Map View',
			'newListPage.shareWithFriends' => 'Share with Friends',
			'newListPage.createList' => 'Create List',
			'itemPage.refreshButton' => 'Refresh',
			'settingsPage.header' => 'Settings',
			_ => null,
		};
	}
}
