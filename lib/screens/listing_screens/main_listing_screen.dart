import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/listing_screens/review_listing_screen.dart';
import 'package:foodreviewapp/widgets/category_review_widget.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/models/category.dart';
import 'package:foodreviewapp/screens/form_screens/review_form_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/widgets/counter_widget.dart';

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
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text(AppLocalizations.of(context)!.reviewTitle),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 155,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.grey),
                            )),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReviewListingScreen(),
                            ),
                          );
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.all_inbox, color: Colors.black),
                            Text(AppLocalizations.of(context)!.allReviews,
                                style: const TextStyle(color: Colors.black)),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 155,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey),
                          )),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewListingScreen(
                                columnName: 'isFavourite',
                                columnValue: '1',
                                titleValue: AppLocalizations.of(context)!
                                    .myFavouritesTitle),
                          ),
                        );
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.favorite, color: Colors.black),
                          Text(AppLocalizations.of(context)!.myFavourites,
                              style: const TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  )
                ],
              )),
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
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CategoryReviewWidget(
                        category: snapshot.data![index],
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewListingScreen(
                                columnName: 'categories',
                                columnValue: snapshot.data![index].name,
                                titleValue: snapshot.data![index].name,
                                description: snapshot.data![index].description,
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
