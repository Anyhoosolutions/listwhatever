///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsSv with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsSv({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.sv,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <sv>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsSv _root = this; // ignore: unused_field

	@override 
	TranslationsSv $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsSv(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'List Whatever';
	@override String get staging => 'Staging';
	@override String get genericLoading => 'Laddar...';
	@override String get genericNoData => 'Inga data';
	@override String get genericError => 'Fel';
	@override String get listConjunction => 'och';
	@override late final _Translations$appShell$sv appShell = _Translations$appShell$sv._(_root);
	@override late final _Translations$mainPage$sv mainPage = _Translations$mainPage$sv._(_root);
	@override late final _Translations$homePage$sv homePage = _Translations$homePage$sv._(_root);
	@override late final _Translations$listItemsPage$sv listItemsPage = _Translations$listItemsPage$sv._(_root);
	@override late final _Translations$itemPage$sv itemPage = _Translations$itemPage$sv._(_root);
	@override late final _Translations$settingsPage$sv settingsPage = _Translations$settingsPage$sv._(_root);
}

// Path: appShell
class _Translations$appShell$sv implements Translations$appShell$en {
	_Translations$appShell$sv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override late final _Translations$appShell$menu$sv menu = _Translations$appShell$menu$sv._(_root);
}

// Path: mainPage
class _Translations$mainPage$sv implements Translations$mainPage$en {
	_Translations$mainPage$sv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get homeTab => 'Hem';
	@override String get counterTab => 'Räknare';
	@override String get settingsTab => 'Inställningar';
}

// Path: homePage
class _Translations$homePage$sv implements Translations$homePage$en {
	_Translations$homePage$sv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get header => 'Mina listor';
	@override String get searchHint => 'Sök listor...';
	@override String itemCount({required Object n}) => '${n} objekt';
	@override String get empty => 'Inga listor matchar filtren';
	@override String get featuredTitle => 'Favoritkaféer';
	@override String get featuredSubtitle => '7 platser taggade.';
	@override String get featuredBadge => 'Kartvy aktiverad.';
}

// Path: listItemsPage
class _Translations$listItemsPage$sv implements Translations$listItemsPage$en {
	_Translations$listItemsPage$sv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get listTab => 'Lista';
	@override String get mapTab => 'Karta';
	@override String get searchHint => 'Sök banor, platser...';
	@override String get empty => 'Inga objekt matchar sökningen';
	@override String get accessPublic => 'Publik';
	@override String get accessPrivate => 'Privat';
	@override String metaLine({required Object access, required Object par}) => '${access} · PAR ${par}';
	@override String ratingLine({required Object rating, required Object location}) => '${rating} · ${location}';
	@override String get directions => 'Vägbeskrivning';
}

// Path: itemPage
class _Translations$itemPage$sv implements Translations$itemPage$en {
	_Translations$itemPage$sv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get refreshButton => 'Uppdatera';
}

// Path: settingsPage
class _Translations$settingsPage$sv implements Translations$settingsPage$en {
	_Translations$settingsPage$sv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get header => 'Inställningar';
}

// Path: appShell.menu
class _Translations$appShell$menu$sv implements Translations$appShell$menu$en {
	_Translations$appShell$menu$sv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Inställningar';
	@override String get profile => 'Profil';
	@override String get logout => 'Logga ut';
}

/// The flat map containing all translations for locale <sv>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsSv {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'List Whatever',
			'staging' => 'Staging',
			'genericLoading' => 'Laddar...',
			'genericNoData' => 'Inga data',
			'genericError' => 'Fel',
			'listConjunction' => 'och',
			'appShell.menu.settings' => 'Inställningar',
			'appShell.menu.profile' => 'Profil',
			'appShell.menu.logout' => 'Logga ut',
			'mainPage.homeTab' => 'Hem',
			'mainPage.counterTab' => 'Räknare',
			'mainPage.settingsTab' => 'Inställningar',
			'homePage.header' => 'Mina listor',
			'homePage.searchHint' => 'Sök listor...',
			'homePage.itemCount' => ({required Object n}) => '${n} objekt',
			'homePage.empty' => 'Inga listor matchar filtren',
			'homePage.featuredTitle' => 'Favoritkaféer',
			'homePage.featuredSubtitle' => '7 platser taggade.',
			'homePage.featuredBadge' => 'Kartvy aktiverad.',
			'listItemsPage.listTab' => 'Lista',
			'listItemsPage.mapTab' => 'Karta',
			'listItemsPage.searchHint' => 'Sök banor, platser...',
			'listItemsPage.empty' => 'Inga objekt matchar sökningen',
			'listItemsPage.accessPublic' => 'Publik',
			'listItemsPage.accessPrivate' => 'Privat',
			'listItemsPage.metaLine' => ({required Object access, required Object par}) => '${access} · PAR ${par}',
			'listItemsPage.ratingLine' => ({required Object rating, required Object location}) => '${rating} · ${location}',
			'listItemsPage.directions' => 'Vägbeskrivning',
			'itemPage.refreshButton' => 'Uppdatera',
			'settingsPage.header' => 'Inställningar',
			_ => null,
		};
	}
}
