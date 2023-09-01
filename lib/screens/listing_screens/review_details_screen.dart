import 'package:flutter/material.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:foodreviewapp/screens/form_screens/review_form_screen.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewDetailsScreen extends StatefulWidget {
  final int reviewId;
  const ReviewDetailsScreen({super.key, required this.reviewId});

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  Review? reviewObject;
  bool isLoading = false;
  bool isFavourite = false;
  @override
  void initState() {
    super.initState();
    _getReview();
  }

  Future _getReview() async {
    setState(() {
      isLoading = true;
    });
    reviewObject = await DatabaseService.getReviewById(widget.reviewId);
    isFavourite = reviewObject?.isFavourite ?? false;
    setState(() {
      isLoading = false;
    });
  }

  void _toggleFavourite() async {
    await DatabaseService.updateReviewFavourite(
        reviewObject!.id!, isFavourite ? 0 : 1);
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        elevation: 0,
        actions: [
          isFavourite
              ? IconButton(
                  onPressed: _toggleFavourite,
                  icon: const Icon(Icons.favorite),
                )
              : IconButton(
                  onPressed: _toggleFavourite,
                  icon: const Icon(Icons.favorite_border),
                ),
        ],
      ),
      body: LiquidPullToRefresh(
        color: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        showChildOpacityTransition: false,
        onRefresh: () async {
          await _getReview();
        },
        child: Stack(
          children: [
            SizedBox(
                width: double.infinity,
                height: 0.5 * MediaQuery.of(context).size.height,
                child: reviewObject?.image != null
                    ? Image.memory(reviewObject!.image!)
                    : Image.asset('assets/images/default_restaurant.png')),
            DraggableScrollableSheet(
              maxChildSize: 1,
              initialChildSize: 0.55,
              minChildSize: 0.55,
              builder: (context, scrollController) => SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 40, right: 14, left: 14),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //-----Restaurant Name-----
                                  Flexible(
                                    child: Text(
                                      "${reviewObject?.restaurantName}",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  //-----Rating-----
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 24),
                                      Text(
                                        "${reviewObject?.rating.toString()}",
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                            const SizedBox(height: 16),
                            //-----Location-----
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                Flexible(
                                  child: Text(
                                    "${reviewObject?.location}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  height: 4,
                                  thickness: 2,
                                )),
                            //-----Description-----
                            Text(AppLocalizations.of(context)!.description,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(
                              "${reviewObject?.description}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(height: 4, thickness: 2)),
                            //-----Food Available-----
                            Text(AppLocalizations.of(context)!.foodAvailable,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: reviewObject?.foodAvailable.length,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Chip(
                                    label: Text(
                                      "${reviewObject?.foodAvailable[index]}",
                                    ),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(height: 4, thickness: 2)),
                            //-----Additional Review-----
                            Text(AppLocalizations.of(context)!.additionalReview,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(
                              reviewObject?.additionalReview != null
                                  ? "${reviewObject?.additionalReview}"
                                  : AppLocalizations.of(context)!
                                      .noAdditionalReview,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(height: 4, thickness: 2)),
                            //-----Link-----
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey), // Border color
                                  ),
                                  child: IconButton(
                                      onPressed: () async {
                                        final url = Uri.parse(
                                            'https://www.google.com/search?q=${reviewObject?.restaurantName} restaurant');
                                        if (!await launchUrl(url,
                                            mode: LaunchMode
                                                .externalApplication)) {
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                      icon: const Icon(Icons.search)),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey), // Border color
                                  ),
                                  child: IconButton(
                                      onPressed: () async {
                                        final url = Uri.parse(
                                            'https://www.google.com/maps/search/${reviewObject?.location}');
                                        if (!await launchUrl(url,
                                            mode: LaunchMode
                                                .externalApplication)) {
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                      icon:
                                          const Icon(Icons.location_on_sharp)),
                                ),
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(height: 4, thickness: 2)),
                            //-----Edit and Delete Button-----
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ReviewFormScreen(
                                                    review: reviewObject),
                                          ),
                                        );
                                        _getReview();
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.edit),
                                          Text(AppLocalizations.of(context)!
                                              .editReviewButton)
                                        ],
                                      )),
                                  ElevatedButton(
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  title: Center(
                                                    child: Text(AppLocalizations
                                                            .of(context)!
                                                        .deleteReviewButton),
                                                  ),
                                                  content: Text(AppLocalizations
                                                          .of(context)!
                                                      .deleteReviewDialogMessage),
                                                  actions: [
                                                    ButtonBar(
                                                      alignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .no),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await DatabaseService
                                                                .deleteReview(
                                                                    reviewObject!);
                                                            // ignore: use_build_context_synchronously
                                                            Navigator.pop(
                                                                context);
                                                            // ignore: use_build_context_synchronously
                                                            Navigator.pop(
                                                                context);
                                                            // ignore: use_build_context_synchronously
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  // ignore: use_build_context_synchronously
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .reviewDeletedSnackbar,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black)),
                                                              backgroundColor:
                                                                  Colors.green[
                                                                      100],
                                                            ));
                                                          },
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .yes,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .red)),
                                                        ),
                                                      ],
                                                    )
                                                  ]);
                                            });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.delete),
                                          Text(AppLocalizations.of(context)!
                                              .deleteReviewButton)
                                        ],
                                      ))
                                ]),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
