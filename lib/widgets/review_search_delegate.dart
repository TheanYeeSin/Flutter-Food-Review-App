import 'package:flutter/material.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:foodreviewapp/widgets/review_widget.dart';
import 'package:foodreviewapp/screens/listing_screens/review_details_screen.dart';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:foodreviewapp/utils/display.dart';

class ReviewSearchDelegate extends SearchDelegate<String> {
  final String? columnName;
  final String? columnValue;

  ReviewSearchDelegate({
    this.columnName,
    this.columnValue,
  });

  Future<List<Review>?> _getReviews() {
    if (columnName != null && columnValue != null) {
      // Return reviews by column
      return DatabaseService.getReviewsByColumn(
        columnName!,
        columnValue!,
      );
    } else {
      // Return all reviews
      return DatabaseService.getAllReviews();
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    int selectedDisplayMode = context.watch<DisplayManager>().displayMode;
    return FutureBuilder<List<Review>?>(
        future: _getReviews(),
        builder: (context, AsyncSnapshot<List<Review>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong! Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final List<Review>? allReviews = snapshot.data;
            List<Review>? searchResults = allReviews
                ?.where((review) => review.restaurantName
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .toList();
            return selectedDisplayMode != 2
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return ReviewWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewDetailsScreen(
                                reviewId: searchResults[index].id!,
                              ),
                            ),
                          );
                        },
                        review: searchResults[index],
                      );
                    },
                    itemCount: searchResults!.length,
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust as needed
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: searchResults!.length,
                    itemBuilder: (context, index) {
                      return ReviewWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewDetailsScreen(
                                reviewId: searchResults[index].id!,
                              ),
                            ),
                          );
                        },
                        review: searchResults[index],
                      );
                    },
                  );
          }
          return Center(
              child: Text(AppLocalizations.of(context)!.noReviewFound));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Review>?>(
        future: _getReviews(),
        builder: (context, AsyncSnapshot<List<Review>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong! Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final List<Review>? allReviews = snapshot.data;
            const int maxSuggestions = 10;
            final random = Random();
            List<String> filteredNames = allReviews
                    ?.where((review) => review.restaurantName
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .map((review) => review.restaurantName)
                    .toList() ??
                [];
            filteredNames.shuffle(random);
            filteredNames = filteredNames.take(maxSuggestions).toList();
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredNames[index]),
                  onTap: () {
                    query = filteredNames[index];
                    showResults(context);
                  },
                );
              },
              itemCount: filteredNames.length,
            );
          }
          return Center(
              child: Text(AppLocalizations.of(context)!.noSuggestion));
        });
  }
}
