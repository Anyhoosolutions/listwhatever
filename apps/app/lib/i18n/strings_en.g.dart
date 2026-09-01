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

	/// en: 'Hem'
	String get homeTab => 'Hem';

	/// en: 'Räknare'
	String get counterTab => 'Räknare';

	/// en: 'Inställningar'
	String get settingsTab => 'Inställningar';
}

// Path: homePage
class Translations$homePage$en {
	Translations$homePage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hem'
	String get header => 'Hem';

	/// en: 'Öppna exempelobjekt'
	String get openButton => 'Öppna exempelobjekt';
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

	/// en: 'Inställningar'
	String get header => 'Inställningar';
}

// Path: appShell.menu
class Translations$appShell$menu$en {
	Translations$appShell$menu$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Inställningar'
	String get settings => 'Inställningar';

	/// en: 'Profil'
	String get profile => 'Profil';

	/// en: 'Logga ut'
	String get logout => 'Logga ut';
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
			'appShell.menu.settings' => 'Inställningar',
			'appShell.menu.profile' => 'Profil',
			'appShell.menu.logout' => 'Logga ut',
			'mainPage.homeTab' => 'Hem',
			'mainPage.counterTab' => 'Räknare',
			'mainPage.settingsTab' => 'Inställningar',
			'homePage.header' => 'Hem',
			'homePage.openButton' => 'Öppna exempelobjekt',
			'itemPage.refreshButton' => 'Refresh',
			'settingsPage.header' => 'Inställningar',
			_ => null,
		};
	}
}
