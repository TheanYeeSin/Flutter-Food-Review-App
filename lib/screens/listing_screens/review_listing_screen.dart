import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/random_restaurant_screen.dart';
import 'package:foodreviewapp/screens/listing_screens/review_details_screen.dart';
import 'package:foodreviewapp/widgets/review_widget.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:foodreviewapp/widgets/review_search_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:foodreviewapp/utils/display.dart';

class ReviewListingScreen extends StatefulWidget {
  final String? columnName;
  final String? columnValue;
  final String? titleValue;
  final String? description;
  const ReviewListingScreen(
      {super.key,
      this.columnName,
      this.columnValue,
      this.titleValue,
      this.description});

  @override
  State<ReviewListingScreen> createState() => _ReviewListingScreenState();
}

class _ReviewListingScreenState extends State<ReviewListingScreen> {
  bool isLoading = false;
  String _selectedColumnName = 'restaurantName';
  bool _sortAscending = true;

  void _onSortOptionChanged(String columnName) {
    setState(() {
      if (_selectedColumnName == columnName) {
        _sortAscending = !_sortAscending;
      } else {
        _selectedColumnName = columnName;
        _sortAscending = true;
      }
      _refresh();
    });
  }

  Future<List<Review>?> _getReviews() {
    if (widget.columnName != null && widget.columnValue != null) {
      // Return reviews by column
      return DatabaseService.getReviewsByColumn(
        widget.columnName!,
        widget.columnValue!,
        orderBy: '$_selectedColumnName ${_sortAscending ? 'ASC' : 'DESC'}',
      );
    } else {
      // Return all reviews
      return DatabaseService.getAllReviews(
          orderBy: '$_selectedColumnName ${_sortAscending ? 'ASC' : 'DESC'}');
    }
  }

  Future _refresh() async {
    setState(() {
      isLoading = true;
    });
    await _getReviews();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedDisplayMode = context.watch<DisplayManager>().displayMode;
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.titleValue ?? AppLocalizations.of(context)!.allTitle),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: ReviewSearchDelegate(
                        columnName: widget.columnName,
                        columnValue: widget.columnValue));
                setState(() {});
              },
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton(
              onSelected: _onSortOptionChanged,
              icon: const Icon(Icons.sort),
              itemBuilder: (BuildContext context) => [
                _buildSortMenuItem('restaurantName',
                    AppLocalizations.of(context)!.restaurantNameSort),
                _buildSortMenuItem(
                    'rating', AppLocalizations.of(context)!.ratingSort),
                _buildSortMenuItem('createdTime',
                    AppLocalizations.of(context)!.createdTimeSort),
              ],
            )
          ],
        ),
        body: LiquidPullToRefresh(
          color: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          showChildOpacityTransition: false,
          onRefresh: () async {
            await _refresh();
          },
          child: FutureBuilder<List<Review>?>(
              future: _getReviews(),
              builder: (context, AsyncSnapshot<List<Review>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Something went wrong! Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: widget.description != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: Text(widget.description!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        fontStyle: FontStyle.italic)),
                              )
                            : const SizedBox.shrink(),
                      ),
                      selectedDisplayMode != 2
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return ReviewWidget(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewDetailsScreen(
                                            reviewId: snapshot.data![index].id!,
                                          ),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                    review: snapshot.data![index],
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
                                  return ReviewWidget(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewDetailsScreen(
                                            reviewId: snapshot.data![index].id!,
                                          ),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                    review: snapshot.data![index],
                                  );
                                },
                                childCount: snapshot.data!.length,
                              ))
                    ],
                  );
                }
                return Center(
                    child: Text(AppLocalizations.of(context)!.noReviewYet));
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RandomRestaurantScreen(
                  columnName: widget.columnName,
                  columnValue: widget.columnValue,
                ),
              ),
            );
            setState(() {});
          },
          child: const Icon(Icons.shuffle),
        ));
  }

  PopupMenuItem<String> _buildSortMenuItem(String columnName, String label) {
    final isSelected = _selectedColumnName == columnName;
    final sortIcon = isSelected
        ? _sortAscending
            ? Icons.arrow_upward
            : Icons.arrow_downward
        : null;
    return PopupMenuItem(
      value: columnName,
      child: Row(
        children: [
          Text(label),
          const Spacer(),
          if (sortIcon != null) Icon(sortIcon),
        ],
      ),
    );
  }
}
