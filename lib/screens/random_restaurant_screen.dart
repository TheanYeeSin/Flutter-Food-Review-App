import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Random Restaurant Screen (required 2 or more reviews)
class RandomRestaurantScreen extends StatefulWidget {
  final String? columnName;
  final String? columnValue;
  const RandomRestaurantScreen({super.key, this.columnName, this.columnValue});

  @override
  State<RandomRestaurantScreen> createState() => _RandomRestaurantScreenState();
}

class _RandomRestaurantScreenState extends State<RandomRestaurantScreen> {
  final selected = BehaviorSubject<int>();
  String result = '';

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  Future<List<Review>?> _getReviews() {
    if (widget.columnName != null && widget.columnValue != null) {
      // Return reviews by column
      return DatabaseService.getReviewsByColumn(
        widget.columnName!,
        widget.columnValue!,
      );
    } else {
      // Return all reviews
      return DatabaseService.getAllReviews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.randomRestaurantTitle),
      ),
      body: Center(
        child: FutureBuilder(
          future: _getReviews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong! Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.length > 1) {
              final List<String> restaurantNames = snapshot.data!
                  .map((review) => review.restaurantName)
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: FortuneWheel(
                          physics: CircularPanPhysics(
                            duration: const Duration(seconds: 1),
                            curve: Curves.decelerate,
                          ),
                          selected: selected.stream,
                          animateFirst: false,
                          onFling: () {
                            selected.add(
                              Fortune.randomInt(0, restaurantNames.length),
                            );
                          },
                          items: restaurantNames
                              .map(
                                (restaurant) =>
                                    FortuneItem(child: Text(restaurant)),
                              )
                              .toList(),
                          onAnimationEnd: () {
                            result = restaurantNames[selected.value];
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .randomRestaurantSnackbar(result),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selected.add(
                              Fortune.randomInt(0, restaurantNames.length));
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          color: Colors.redAccent,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .randomRestaurantSpin,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                AppLocalizations.of(context)!.notEnoughRestaurantsError,
              ),
            );
          },
        ),
      ),
    );
  }
}
