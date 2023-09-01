import 'app_localizations.dart';

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get reviewTitle => '评论';

  @override
  String get searchTitle => '搜索';

  @override
  String get randomRestaurantTitle => '随机餐厅';

  @override
  String get myFavouritesTitle => '我的最爱';

  @override
  String get categoriesSettingTitle => '类别设置';

  @override
  String get settingsTitle => '设置';

  @override
  String get appearanceSettingTitle => '外观设置';

  @override
  String get notificationsSettingTitle => '通知设置';

  @override
  String get generalSettingTitle => '一般设置';

  @override
  String get addReviewTitle => '添加评论';

  @override
  String get editReviewTitle => '编辑评论';

  @override
  String get addCategoryTitle => '添加类别';

  @override
  String get editCategoryTitle => '编辑类别';

  @override
  String get backupRestoreSettingTitle => '备份 & 恢复设置';

  @override
  String get advancedSettingTitle => '高级设置';

  @override
  String get allReviews => '全部评论';

  @override
  String get myFavourites => '我的最爱';

  @override
  String get allTitle => '全部';

  @override
  String get view => '查看';

  @override
  String get restaurantNameSort => '餐厅名称';

  @override
  String get ratingSort => '评分';

  @override
  String get createdTimeSort => '创建时间';

  @override
  String get randomRestaurantSpin => '随机餐厅';

  @override
  String get restaurantName => '餐厅名称';

  @override
  String get location => '餐厅位置';

  @override
  String get description => '餐厅描述';

  @override
  String get foodAvailableComma => '食物提供(逗号分隔)';

  @override
  String get foodAvailable => '食物提供';

  @override
  String get rating => '评分';

  @override
  String get additionalReview => '附加评论';

  @override
  String get noAdditionalReview => '没有附加评论';

  @override
  String get selectCategoriesButton => '选择类别';

  @override
  String get selectCategoriesDialogTitle => '选择类别';

  @override
  String get okay => 'OK';

  @override
  String get addReviewButton => '添加评论';

  @override
  String get editReviewButton => '编辑评论';

  @override
  String get deleteReviewButton => '删除评论';

  @override
  String get deleteReviewDialogTitle => '删除评论';

  @override
  String get deleteReviewDialogMessage => '你确定要删除这条评论吗？';

  @override
  String get no => '不';

  @override
  String get yes => '是';

  @override
  String get pickImage => '选择图片';

  @override
  String get changeImage => '更改图片';

  @override
  String get chooseOptionDialogTitle => '选择选项';

  @override
  String get galleryOption => '图库';

  @override
  String get cameraOption => '相机';

  @override
  String get categoryName => '类别名称';

  @override
  String get categoryDescription => '类别描述';

  @override
  String get uploadCategoryImage => '上传图片';

  @override
  String get updateCategoryImage => '更新图片';

  @override
  String get categoryImageUploaded => '图片已上传！';

  @override
  String get cancelButton => '取消';

  @override
  String get addButton => '添加';

  @override
  String get editButton => '编辑';

  @override
  String get deleteCategoryDialogTitle => '删除类别';

  @override
  String get deleteCategoryDialogMessage => '你确定要删除这个类别吗？';

  @override
  String get enterRestaurantNameError => '请输入餐厅名称';

  @override
  String get enterLocationError => '请输入餐厅位置';

  @override
  String get enterDescriptionError => '请输入餐厅描述';

  @override
  String get enterFoodAvailableError => '请输入食物提供';

  @override
  String get enterCategoryNameError => '请输入类别名称';

  @override
  String get enterCategoryDescriptionError => '请输入类别描述';

  @override
  String pickImageError(String e) {
    return '图片选取失败: $e';
  }

  @override
  String get notEnoughRestaurantsError => '至少需要两个餐厅才能使用随机餐厅功能';

  @override
  String get noReviewYet => '还没有评论';

  @override
  String get noCategoryYet => '还没有类别';

  @override
  String get noSuggestion => '没有建议';

  @override
  String get noReviewFound => '没有找到评论';

  @override
  String randomRestaurantSnackbar(String result) {
    return '$result 已被选择！';
  }

  @override
  String get reviewAddedSnackbar => '评论已添加';

  @override
  String get reviewUpdatedSnackbar => '评论已更新！';

  @override
  String get reviewDeletedSnackbar => '评论已删除！';

  @override
  String get categoryAddedSnackbar => '类别已添加！';

  @override
  String get categoryUpdatedSnackbar => '类别已更新！';

  @override
  String get categoryDeletedSnackbar => '类别已删除！';

  @override
  String backUpSuccessSnackbar(String path) {
    return '新备份已创建：$path';
  }

  @override
  String backUpFailedSnackbar(String e) {
    return '备份失败: $e';
  }

  @override
  String get restoreSuccessSnackbar => '恢复成功！';

  @override
  String get restoreFailedSnackbar => '恢复失败';

  @override
  String get deleteDatabaseSuccessSnackbar => '数据库已删除！';

  @override
  String get categoriesSetting => '类别';

  @override
  String get backupRestoreSetting => '备份 & 恢复';

  @override
  String get backupRestoreSettingSubtitle => '备份 & 恢复';

  @override
  String get backupSetting => '备份';

  @override
  String get backupSettingSubtitle => '创建新的备份文件';

  @override
  String get restoreSetting => '恢复';

  @override
  String get restoreSettingSubtitle => '恢复备份文件';

  @override
  String get setting => '设置';

  @override
  String get about => '关于';

  @override
  String get generalSetting => '一般';

  @override
  String get generalSettingSubtitle => '语言';

  @override
  String get languageSetting => '语言';

  @override
  String get appearanceSetting => '外观';

  @override
  String get appearanceSettingSubtitle => '主题';

  @override
  String get themeSetting => '主题';

  @override
  String get lightTheme => '亮主题';

  @override
  String get darkTheme => '暗主题';

  @override
  String get systemDefault => '系统默认';

  @override
  String get librarySetting => '阅览';

  @override
  String get librarySettingSubtitle => '类别，显示方式';

  @override
  String get displaySetting => '显示方式';

  @override
  String get cardView => '卡片视图';

  @override
  String get listView => '列表视图';

  @override
  String get gridView => '网格视图';

  @override
  String get notificationsSetting => '通知';

  @override
  String get notificationsSettingSubtitle => '通知提醒';

  @override
  String get breakfastSetting => '早餐';

  @override
  String get lunchSetting => '午餐';

  @override
  String get dinnerSetting => '晚餐';

  @override
  String get breakfastNotificationTitle => '早餐时间!';

  @override
  String get breakfastNotificationMessage => '早安, 是时候吃早餐了!';

  @override
  String get lunchNotificationTitle => '午餐时间!';

  @override
  String get lunchNotificationMessage => '午餐时间到！享用！';

  @override
  String get dinnerNotificationTitle => '晚餐时间!';

  @override
  String get dinnerNotificationMessage => '晚餐时间， 看看你最爱的餐厅吧！';

  @override
  String get notificationTooltipDialogTitle => '通知权限';

  @override
  String get notificationTooltipDialogMessage => '你需要开启通知和闹钟权限才能使用通知功能。';

  @override
  String get advancedSetting => '高级';

  @override
  String get advancedSettingSubtitle => '开发者选项';

  @override
  String get deleteDatabaseSetting => '删除数据库';

  @override
  String get deleteDatabaseDialogTitle => '删除数据库';

  @override
  String get deleteDatabaseDialogMessage => '你确定要删除数据库吗？';

  @override
  String get reviewNavBar => '评论';

  @override
  String get moreNavBar => '更多';
}
