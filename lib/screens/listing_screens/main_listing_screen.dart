import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/listing_screens/review_listing_screen.dart';
import 'package:foodreviewapp/utils/display.dart';
import 'package:foodreviewapp/widgets/category_review_widget.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/models/category.dart';
import 'package:foodreviewapp/screens/form_screens/review_form_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/widgets/common/custom_divider.dart';
import 'package:foodreviewapp/widgets/common/navigation_button.dart';
import 'package:foodreviewapp/widgets/counter_widget.dart';
import 'package:provider/provider.dart';

class MainListingScreen extends StatefulWidget {
  const MainListingScreen({super.key});

  @override
  State<MainListingScreen> createState() => _MainListingScreenState();
}

class _MainListingScreenState extends State<MainListingScreen> {
  Future<List<Category>?> _getAllCategory() {
    // Return all categories
    return DatabaseService.getAllCategories();
  }

  Future<int> _countAllReview() async {
    var reviews = await DatabaseService.getAllReviews();
    return reviews?.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    int selectedDisplayMode =
        context.watch<DisplayManager>().categoryDisplayMode;
    return Scaffold(
      appBar: AppBar(
          title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 2, right: 10),
            width: 25,
            height: 25,
            child: Theme.of(context).brightness == Brightness.light
                ? Image.asset('assets/icons/logo_with_less_padding.png')
                : Image.asset('assets/icons/logo_white_with_less_padding.png'),
          ),
          Text(
            AppLocalizations.of(context)!.reviewTitle,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(width: 10),
          FutureBuilder(
              future: _countAllReview(),
              builder: (context, AsyncSnapshot<int> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Something went wrong! Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  return CounterWidget(count: snapshot.data);
                }
                return const CounterWidget(count: 0);
              })
        ],
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 8),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavigationButton(
                  icon: const Icon(Icons.all_inbox, color: Colors.black),
                  labelText: AppLocalizations.of(context)!.allReviews,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReviewListingScreen(),
                      ),
                    );
                    setState(() {});
                  },
                ),
                NavigationButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  labelText: AppLocalizations.of(context)!.myFavorites,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewListingScreen(
                            columnName: 'isFavourite',
                            columnValue: '1',
                            titleValue:
                                AppLocalizations.of(context)!.myFavoritesTitle),
                      ),
                    );
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          const CustomDivider(
              symmetricPadding: 8, dividerHeight: 4, dividerThickness: 2),
          Expanded(
            flex: 8,
            child: FutureBuilder<List<Category>?>(
              future: _getAllCategory(),
              builder: (context, AsyncSnapshot<List<Category>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Something went wrong! Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  return CustomScrollView(
                    slivers: [
                      selectedDisplayMode != 1
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return CategoryReviewWidget(
                                    category: snapshot.data![index],
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewListingScreen(
                                            columnName: 'categories',
                                            columnValue:
                                                snapshot.data![index].name,
                                            titleValue:
                                                snapshot.data![index].name,
                                            description: snapshot
                                                .data![index].description,
                                          ),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                  );
                                },
                                childCount: snapshot.data!.length,
                              ),
                            )
                          : SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Adjust as needed
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return CategoryReviewWidget(
                                    category: snapshot.data![index],
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewListingScreen(
                                            columnName: 'categories',
                                            columnValue:
                                                snapshot.data![index].name,
                                            titleValue:
                                                snapshot.data![index].name,
                                            description: snapshot
                                                .data![index].description,
                                          ),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                  );
                                },
                                childCount: snapshot.data!.length,
                              ))
                    ],
                  );
                }
                return Center(
                    child: Text(AppLocalizations.of(context)!.noReviewYet));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReviewFormScreen(),
            ),
          );
          setState(() {});
          // ignore: use_build_context_synchronously
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
