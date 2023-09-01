import 'package:flutter/material.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/utils/display.dart';
import 'package:provider/provider.dart';

class ReviewWidget extends StatefulWidget {
  final Review review;
  final VoidCallback onPressed;
  const ReviewWidget(
      {super.key, required this.review, required this.onPressed});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.review.isFavourite;
  }

  void _toggleFavourite() async {
    await DatabaseService.updateReviewFavourite(
        widget.review.id!, isFavourite ? 0 : 1);
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedDisplayMode = context.watch<DisplayManager>().displayMode;

    if (selectedDisplayMode == 1) {
      // ListView display mode
      return ListTile(
        // Customize the ListTile based on your preferences
        title: Text(
          widget.review.restaurantName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        subtitle: Text(
          widget.review.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        leading: SizedBox(
          height: 50,
          width: 50,
          child: widget.review.image != null
              ? Image.memory(widget.review.image!)
              : Image.asset('assets/images/default_restaurant.png'),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: isFavourite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              onPressed: _toggleFavourite,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: widget.onPressed,
            ),
          ],
        ),
        onTap: widget.onPressed,
      );
    } else if (selectedDisplayMode == 2) {
      // GridView display mode
      return InkWell(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 85,
                      child: widget.review.image != null
                          ? Image.memory(widget.review.image!)
                          : Image.asset('assets/images/default_restaurant.png'),
                    ),
                    Positioned(
                        right: 2,
                        top: 2,
                        child: isFavourite
                            ? IconButton(
                                icon: const Icon(Icons.favorite),
                                onPressed: _toggleFavourite,
                              )
                            : IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: _toggleFavourite)),
                  ],
                ),
                ListTile(
                  title: Text(
                    widget.review.restaurantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  subtitle: Text(
                    widget.review.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: widget.onPressed,
                child: Ink(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 160,
                        child: Stack(children: [
                          Center(
                            child: widget.review.image != null
                                ? Image.memory(
                                    widget.review.image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/default_restaurant.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Positioned(
                              right: 15,
                              top: 15,
                              child: isFavourite
                                  ? IconButton(
                                      icon: const Icon(Icons.favorite),
                                      onPressed: _toggleFavourite,
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.favorite_border),
                                      onPressed: _toggleFavourite)),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(widget.review.restaurantName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  Row(children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      widget.review.rating.toString(),
                                    ),
                                  ])
                                ]),
                            const SizedBox(height: 5),
                            Text(
                              widget.review.description,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 3,
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                TextButton(
                                    onPressed: widget.onPressed,
                                    child: Text(
                                        AppLocalizations.of(context)!.view))
                              ],
                            )
                          ],
                        ),
                      ),
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
}
