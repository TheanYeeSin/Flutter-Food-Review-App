import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// Reviews Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviewTitle;

  /// Search Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// Random Restaurant Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Random Restaurant'**
  String get randomRestaurantTitle;

  /// My Favourites Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'My Favourites'**
  String get myFavouritesTitle;

  /// Categories Setting Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Categories Setting'**
  String get categoriesSettingTitle;

  /// Settings Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Appearance Setting Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Appearance Setting'**
  String get appearanceSettingTitle;

  /// Notifications Setting Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Notifications Setting'**
  String get notificationsSettingTitle;

  /// General Setting Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'General Setting'**
  String get generalSettingTitle;

  /// Add Review Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReviewTitle;

  /// Edit Review Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get editReviewTitle;

  /// Add Category Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategoryTitle;

  /// Edit Category Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategoryTitle;

  /// Backup & Restore Setting Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore Setting'**
  String get backupRestoreSettingTitle;

  /// Advanced Setting Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'Advanced Setting'**
  String get advancedSettingTitle;

  /// All Reviews Button
  ///
  /// In en, this message translates to:
  /// **'All Reviews'**
  String get allReviews;

  /// My Favourites Button
  ///
  /// In en, this message translates to:
  /// **'My Favourites'**
  String get myFavourites;

  /// All Title on the App Bar
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allTitle;

  /// View Button
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// Restaurant Name Sorting
  ///
  /// In en, this message translates to:
  /// **'Restaurant Name'**
  String get restaurantNameSort;

  /// Rating Sorting
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingSort;

  /// Created Time Sorting
  ///
  /// In en, this message translates to:
  /// **'Created Time'**
  String get createdTimeSort;

  /// Spin Button on random restaurant page
  ///
  /// In en, this message translates to:
  /// **'Spin'**
  String get randomRestaurantSpin;

  /// Restaurant Name
  ///
  /// In en, this message translates to:
  /// **'Restaurant Name'**
  String get restaurantName;

  /// Location
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Description
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Food Available (Comma-separated)
  ///
  /// In en, this message translates to:
  /// **'Food Available (Comma-separated)'**
  String get foodAvailableComma;

  /// Food Available
  ///
  /// In en, this message translates to:
  /// **'Food Available'**
  String get foodAvailable;

  /// Rating
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// Additional Review
  ///
  /// In en, this message translates to:
  /// **'Additional Review'**
  String get additionalReview;

  /// No Additional Review
  ///
  /// In en, this message translates to:
  /// **'No Additional Review'**
  String get noAdditionalReview;

  /// No description provided for @selectCategoriesButton.
  ///
  /// In en, this message translates to:
  /// **'Select Categories'**
  String get selectCategoriesButton;

  /// Select Categories Dialog Title
  ///
  /// In en, this message translates to:
  /// **'Select Categories'**
  String get selectCategoriesDialogTitle;

  /// OK Button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okay;

  /// Add Review Button
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReviewButton;

  /// Edit Review Button
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get editReviewButton;

  /// Delete Review Button
  ///
  /// In en, this message translates to:
  /// **'Delete Review'**
  String get deleteReviewButton;

  /// Delete Review Dialog Title
  ///
  /// In en, this message translates to:
  /// **'Delete Review'**
  String get deleteReviewDialogTitle;

  /// Delete Review Dialog Message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this review?'**
  String get deleteReviewDialogMessage;

  /// No Button
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Yes Button
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// Pick Image Button
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pickImage;

  /// Change Image Button
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get changeImage;

  /// Choose option Dialog Title
  ///
  /// In en, this message translates to:
  /// **'Choose option'**
  String get chooseOptionDialogTitle;

  /// Gallery Option
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryOption;

  /// Camera Option
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraOption;

  /// Category Name
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// Category Description
  ///
  /// In en, this message translates to:
  /// **'Category Description'**
  String get categoryDescription;

  /// Upload Image Button for Category
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadCategoryImage;

  /// Update Image Button for Category
  ///
  /// In en, this message translates to:
  /// **'Update Image'**
  String get updateCategoryImage;

  /// Image uploaded Message for Category
  ///
  /// In en, this message translates to:
  /// **'Image uploaded!'**
  String get categoryImageUploaded;

  /// Cancel Button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Add Button
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// Edit Button
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// Delete Category Dialog Title
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategoryDialogTitle;

  /// Delete Category Dialog Message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get deleteCategoryDialogMessage;

  /// Please enter a restaurant name Error Message
  ///
  /// In en, this message translates to:
  /// **'Please enter a restaurant name'**
  String get enterRestaurantNameError;

  /// Please enter a location Error Message
  ///
  /// In en, this message translates to:
  /// **'Please enter a location'**
  String get enterLocationError;

  /// Please enter a description Error Message
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get enterDescriptionError;

  /// Please enter food available Error Message
  ///
  /// In en, this message translates to:
  /// **'Please enter food available'**
  String get enterFoodAvailableError;

  /// Please enter a category name Error Message
  ///
  /// In en, this message translates to:
  /// **'Please enter a category name'**
  String get enterCategoryNameError;

  /// Please enter a category description Error Message
  ///
  /// In en, this message translates to:
  /// **'Please enter a category description'**
  String get enterCategoryDescriptionError;

  /// Failed to pick image Error Message
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image: {e}'**
  String pickImageError(String e);

  /// Not enough restaurants Error Message
  ///
  /// In en, this message translates to:
  /// **'Need at least 2 restaurants to spin!'**
  String get notEnoughRestaurantsError;

  /// No review yet Message
  ///
  /// In en, this message translates to:
  /// **'No review yet'**
  String get noReviewYet;

  /// No category yet Message
  ///
  /// In en, this message translates to:
  /// **'No category yet'**
  String get noCategoryYet;

  /// No suggestion Message
  ///
  /// In en, this message translates to:
  /// **'No suggestion'**
  String get noSuggestion;

  /// No review found Message
  ///
  /// In en, this message translates to:
  /// **'No review found'**
  String get noReviewFound;

  /// Random Restaurant Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'{result} was selected!'**
  String randomRestaurantSnackbar(String result);

  /// Review added Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Review added!'**
  String get reviewAddedSnackbar;

  /// Review updated Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Review updated!'**
  String get reviewUpdatedSnackbar;

  /// Review deleted Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Review deleted!'**
  String get reviewDeletedSnackbar;

  /// Category added Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Category added!'**
  String get categoryAddedSnackbar;

  /// Category updated Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Category updated!'**
  String get categoryUpdatedSnackbar;

  /// Category deleted Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Category deleted!'**
  String get categoryDeletedSnackbar;

  /// Backup successful Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'New backup created at {path}!'**
  String backUpSuccessSnackbar(String path);

  /// Backup failed Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Failed to create backup: {e}'**
  String backUpFailedSnackbar(String e);

  /// Restore successful Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Backup restored!'**
  String get restoreSuccessSnackbar;

  /// Restore failed Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Failed to restore backup: '**
  String get restoreFailedSnackbar;

  /// Delete Database successful Snackbar Message
  ///
  /// In en, this message translates to:
  /// **'Database deleted!'**
  String get deleteDatabaseSuccessSnackbar;

  /// Categories Setting
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesSetting;

  /// Backup & Restore Setting
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backupRestoreSetting;

  /// Backup & Restore Setting Subtitle
  ///
  /// In en, this message translates to:
  /// **'Backup, Restore'**
  String get backupRestoreSettingSubtitle;

  /// Backup Setting
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupSetting;

  /// Backup Setting Subtitle
  ///
  /// In en, this message translates to:
  /// **'Create a new backup file'**
  String get backupSettingSubtitle;

  /// Restore Setting
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreSetting;

  /// Restore Setting Subtitle
  ///
  /// In en, this message translates to:
  /// **'Restore from a backup file'**
  String get restoreSettingSubtitle;

  /// Setting
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// About
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// General Setting
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalSetting;

  /// General Setting Subtitle
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get generalSettingSubtitle;

  /// Language Setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSetting;

  /// Appearance Setting
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSetting;

  /// Appearance Setting Subtitle
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get appearanceSettingSubtitle;

  /// Theme Setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSetting;

  /// Light Theme
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// Dark Theme
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// System Default
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Library Setting
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get librarySetting;

  /// Library Setting Subtitle
  ///
  /// In en, this message translates to:
  /// **'Categories, Display Method'**
  String get librarySettingSubtitle;

  /// Display Method Setting
  ///
  /// In en, this message translates to:
  /// **'Display Method'**
  String get displaySetting;

  /// Card View
  ///
  /// In en, this message translates to:
  /// **'Card View'**
  String get cardView;

  /// List View
  ///
  /// In en, this message translates to:
  /// **'List View'**
  String get listView;

  /// Grid View
  ///
  /// In en, this message translates to:
  /// **'Grid View'**
  String get gridView;

  /// Notifications Setting
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSetting;

  /// Notifications Setting Subtitle
  ///
  /// In en, this message translates to:
  /// **'Reminder, Alert'**
  String get notificationsSettingSubtitle;

  /// Breakfast Setting
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfastSetting;

  /// Lunch Setting
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunchSetting;

  /// Dinner Setting
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinnerSetting;

  /// Breakfast Notification Title
  ///
  /// In en, this message translates to:
  /// **'Breakfast!'**
  String get breakfastNotificationTitle;

  /// Breakfast Notification Message
  ///
  /// In en, this message translates to:
  /// **'Morning, time for breakfast!'**
  String get breakfastNotificationMessage;

  /// Lunch Notification Title
  ///
  /// In en, this message translates to:
  /// **'Lunch!'**
  String get lunchNotificationTitle;

  /// Lunch Notification Message
  ///
  /// In en, this message translates to:
  /// **'It\'s time for lunch! Enjoy!'**
  String get lunchNotificationMessage;

  /// Dinner Notification Title
  ///
  /// In en, this message translates to:
  /// **'Dinner!'**
  String get dinnerNotificationTitle;

  /// Dinner Notification Message
  ///
  /// In en, this message translates to:
  /// **'Dinner Time! Check out your favourite restaurant!'**
  String get dinnerNotificationMessage;

  /// Notification Tooltip Dialog Title
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get notificationTooltipDialogTitle;

  /// Notification Tooltip Dialog Message
  ///
  /// In en, this message translates to:
  /// **'Please enable notification and alarm/reminder permission in Settings'**
  String get notificationTooltipDialogMessage;

  /// Advanced Setting
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advancedSetting;

  /// Advanced Setting Subtitle
  ///
  /// In en, this message translates to:
  /// **'Optimization'**
  String get advancedSettingSubtitle;

  /// Delete Database Setting
  ///
  /// In en, this message translates to:
  /// **'Delete Database'**
  String get deleteDatabaseSetting;

  /// Delete Database Dialog Title
  ///
  /// In en, this message translates to:
  /// **'Delete Database'**
  String get deleteDatabaseDialogTitle;

  /// Delete Database Dialog Message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the database?'**
  String get deleteDatabaseDialogMessage;

  /// Reviews Navigation Bar
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviewNavBar;

  /// More Navigation Bar
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreNavBar;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
