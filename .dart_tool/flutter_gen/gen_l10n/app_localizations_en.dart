import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get reviewTitle => 'Reviews';

  @override
  String get searchTitle => 'Search';

  @override
  String get randomRestaurantTitle => 'Random Restaurant';

  @override
  String get myFavouritesTitle => 'My Favourites';

  @override
  String get categoriesSettingTitle => 'Categories Setting';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appearanceSettingTitle => 'Appearance Setting';

  @override
  String get notificationsSettingTitle => 'Notifications Setting';

  @override
  String get generalSettingTitle => 'General Setting';

  @override
  String get addReviewTitle => 'Add Review';

  @override
  String get editReviewTitle => 'Edit Review';

  @override
  String get addCategoryTitle => 'Add Category';

  @override
  String get editCategoryTitle => 'Edit Category';

  @override
  String get backupRestoreSettingTitle => 'Backup & Restore Setting';

  @override
  String get advancedSettingTitle => 'Advanced Setting';

  @override
  String get allReviews => 'All Reviews';

  @override
  String get myFavourites => 'My Favourites';

  @override
  String get allTitle => 'All';

  @override
  String get view => 'View';

  @override
  String get restaurantNameSort => 'Restaurant Name';

  @override
  String get ratingSort => 'Rating';

  @override
  String get createdTimeSort => 'Created Time';

  @override
  String get randomRestaurantSpin => 'Spin';

  @override
  String get restaurantName => 'Restaurant Name';

  @override
  String get location => 'Location';

  @override
  String get description => 'Description';

  @override
  String get foodAvailableComma => 'Food Available (Comma-separated)';

  @override
  String get foodAvailable => 'Food Available';

  @override
  String get rating => 'Rating';

  @override
  String get additionalReview => 'Additional Review';

  @override
  String get noAdditionalReview => 'No Additional Review';

  @override
  String get selectCategoriesButton => 'Select Categories';

  @override
  String get selectCategoriesDialogTitle => 'Select Categories';

  @override
  String get okay => 'OK';

  @override
  String get addReviewButton => 'Add Review';

  @override
  String get editReviewButton => 'Edit Review';

  @override
  String get deleteReviewButton => 'Delete Review';

  @override
  String get deleteReviewDialogTitle => 'Delete Review';

  @override
  String get deleteReviewDialogMessage => 'Are you sure you want to delete this review?';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get pickImage => 'Pick Image';

  @override
  String get changeImage => 'Change Image';

  @override
  String get chooseOptionDialogTitle => 'Choose option';

  @override
  String get galleryOption => 'Gallery';

  @override
  String get cameraOption => 'Camera';

  @override
  String get categoryName => 'Category Name';

  @override
  String get categoryDescription => 'Category Description';

  @override
  String get uploadCategoryImage => 'Upload Image';

  @override
  String get updateCategoryImage => 'Update Image';

  @override
  String get categoryImageUploaded => 'Image uploaded!';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get addButton => 'Add';

  @override
  String get editButton => 'Edit';

  @override
  String get deleteCategoryDialogTitle => 'Delete Category';

  @override
  String get deleteCategoryDialogMessage => 'Are you sure you want to delete this category?';

  @override
  String get enterRestaurantNameError => 'Please enter a restaurant name';

  @override
  String get enterLocationError => 'Please enter a location';

  @override
  String get enterDescriptionError => 'Please enter a description';

  @override
  String get enterFoodAvailableError => 'Please enter food available';

  @override
  String get enterCategoryNameError => 'Please enter a category name';

  @override
  String get enterCategoryDescriptionError => 'Please enter a category description';

  @override
  String pickImageError(String e) {
    return 'Failed to pick image: $e';
  }

  @override
  String get notEnoughRestaurantsError => 'Need at least 2 restaurants to spin!';

  @override
  String get noReviewYet => 'No review yet';

  @override
  String get noCategoryYet => 'No category yet';

  @override
  String get noSuggestion => 'No suggestion';

  @override
  String get noReviewFound => 'No review found';

  @override
  String randomRestaurantSnackbar(String result) {
    return '$result was selected!';
  }

  @override
  String get reviewAddedSnackbar => 'Review added!';

  @override
  String get reviewUpdatedSnackbar => 'Review updated!';

  @override
  String get reviewDeletedSnackbar => 'Review deleted!';

  @override
  String get categoryAddedSnackbar => 'Category added!';

  @override
  String get categoryUpdatedSnackbar => 'Category updated!';

  @override
  String get categoryDeletedSnackbar => 'Category deleted!';

  @override
  String backUpSuccessSnackbar(String path) {
    return 'New backup created at $path!';
  }

  @override
  String backUpFailedSnackbar(String e) {
    return 'Failed to create backup: $e';
  }

  @override
  String get restoreSuccessSnackbar => 'Backup restored!';

  @override
  String get restoreFailedSnackbar => 'Failed to restore backup: ';

  @override
  String get deleteDatabaseSuccessSnackbar => 'Database deleted!';

  @override
  String get categoriesSetting => 'Categories';

  @override
  String get backupRestoreSetting => 'Backup & Restore';

  @override
  String get backupRestoreSettingSubtitle => 'Backup, Restore';

  @override
  String get backupSetting => 'Backup';

  @override
  String get backupSettingSubtitle => 'Create a new backup file';

  @override
  String get restoreSetting => 'Restore';

  @override
  String get restoreSettingSubtitle => 'Restore from a backup file';

  @override
  String get setting => 'Setting';

  @override
  String get about => 'About';

  @override
  String get generalSetting => 'General';

  @override
  String get generalSettingSubtitle => 'App Language';

  @override
  String get languageSetting => 'Language';

  @override
  String get appearanceSetting => 'Appearance';

  @override
  String get appearanceSettingSubtitle => 'Theme';

  @override
  String get themeSetting => 'Theme';

  @override
  String get lightTheme => 'Light Theme';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get systemDefault => 'System Default';

  @override
  String get librarySetting => 'Library';

  @override
  String get librarySettingSubtitle => 'Categories, Display Method';

  @override
  String get displaySetting => 'Display Method';

  @override
  String get cardView => 'Card View';

  @override
  String get listView => 'List View';

  @override
  String get gridView => 'Grid View';

  @override
  String get notificationsSetting => 'Notifications';

  @override
  String get notificationsSettingSubtitle => 'Reminder, Alert';

  @override
  String get breakfastSetting => 'Breakfast';

  @override
  String get lunchSetting => 'Lunch';

  @override
  String get dinnerSetting => 'Dinner';

  @override
  String get breakfastNotificationTitle => 'Breakfast!';

  @override
  String get breakfastNotificationMessage => 'Morning, time for breakfast!';

  @override
  String get lunchNotificationTitle => 'Lunch!';

  @override
  String get lunchNotificationMessage => 'It\'s time for lunch! Enjoy!';

  @override
  String get dinnerNotificationTitle => 'Dinner!';

  @override
  String get dinnerNotificationMessage => 'Dinner Time! Check out your favourite restaurant!';

  @override
  String get notificationTooltipDialogTitle => 'Permission Required';

  @override
  String get notificationTooltipDialogMessage => 'Please enable notification and alarm/reminder permission in Settings';

  @override
  String get advancedSetting => 'Advanced';

  @override
  String get advancedSettingSubtitle => 'Optimization';

  @override
  String get deleteDatabaseSetting => 'Delete Database';

  @override
  String get deleteDatabaseDialogTitle => 'Delete Database';

  @override
  String get deleteDatabaseDialogMessage => 'Are you sure you want to delete the database?';

  @override
  String get reviewNavBar => 'Reviews';

  @override
  String get moreNavBar => 'More';
}
