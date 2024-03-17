import 'package:flutter/material.dart';
import 'package:foodreviewapp/models/category.dart';
import 'package:foodreviewapp/widgets/category_setting_list_widget.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/screens/form_screens/category_form_screen.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Categories setting screen
class CategoriesSettingScreen extends StatefulWidget {
  const CategoriesSettingScreen({super.key});

  @override
  State<CategoriesSettingScreen> createState() =>
      _CategoriesSettingScreenState();
}

class _CategoriesSettingScreenState extends State<CategoriesSettingScreen> {
  Future<List<Category>?> _getAllCategory() {
    // Return all categories
    return DatabaseService.getAllCategories();
  }

  Future<void> _deleteReviewCategory(String categoryName) async {
    List<Review>? reviews =
        await DatabaseService.getReviewsByColumn('categories', categoryName);
    for (Review review in reviews!) {
      review.categories?.remove(categoryName);
      await DatabaseService.updateReview(review);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.categoriesSettingTitle),
      ),
      body: FutureBuilder<List<Category>?>(
        future: _getAllCategory(),
        builder: (context, AsyncSnapshot<List<Category>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong! Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return CategorySettingListWidget(
                  category: snapshot.data![index],
                  onDelete: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .deleteCategoryDialogTitle,
                            ),
                          ),
                          content: Text(
                            AppLocalizations.of(context)!
                                .deleteCategoryDialogMessage,
                          ),
                          actions: [
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.no,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    _deleteReviewCategory(
                                      snapshot.data![index].name,
                                    );
                                    await DatabaseService.deleteCategory(
                                      snapshot.data![index],
                                    );
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    setState(() {});
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          // ignore: use_build_context_synchronously
                                          AppLocalizations.of(context)!
                                              .categoryDeletedSnackbar,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        backgroundColor: Colors.green[100],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.yes,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onEdit: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryFormScreen(
                          category: snapshot.data![index],
                        ),
                      ),
                    );
                    setState(() {});
                  },
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
          return Center(
            child: Text(AppLocalizations.of(context)!.noCategoryYet),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CategoryFormScreen(),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
