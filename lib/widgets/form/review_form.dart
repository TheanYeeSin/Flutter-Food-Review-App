import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:foodreviewapp/utils/validator.dart';
import 'package:foodreviewapp/widgets/category_selection_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodreviewapp/models/category.dart';
import 'package:foodreviewapp/widgets/common/custom_divider.dart';
import 'package:foodreviewapp/widgets/common/custom_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/utils/image.dart';

class ReviewForm extends StatefulWidget {
  final Review? review;
  const ReviewForm({super.key, this.review});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final restaurantNameController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final foodAvailableController = TextEditingController();
  double _ratingController = 0;
  final reviewController = TextEditingController();
  List<String> _selectedCategories = [];
  final List<Category> _availableCategories = [];
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadReviewData();
  }

  _loadReviewData() {
    if (widget.review != null) {
      restaurantNameController.text = widget.review!.restaurantName;
      locationController.text = widget.review!.location;
      descriptionController.text = widget.review!.description;
      foodAvailableController.text = widget.review!.foodAvailable.join(", ");
      _ratingController = widget.review!.rating;
      reviewController.text = widget.review!.additionalReview ?? "";
      _selectedCategories = widget.review!.categories!;
    }
  }

  _loadCategories() async {
    var categories = await DatabaseService.getAllCategories();
    categories?.forEach((category) {
      setState(() {
        _availableCategories.add(category);
      });
    });
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          // ignore: use_build_context_synchronously
          AppLocalizations.of(context)!.pickImageError(e.message!),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red[100],
      ));
    }
  }

  void _selectCategories() async {
    final selectedCategories = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return CategorySelectionDialog(
          availableCategories: _availableCategories,
          selectedCategories: _selectedCategories,
        );
      },
    );
    if (selectedCategories != null) {
      setState(() {
        _selectedCategories = List.from(selectedCategories);
      });
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                AppLocalizations.of(context)!.chooseOptionDialogTitle,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    title: Text(AppLocalizations.of(context)!.galleryOption),
                    leading: const Icon(
                      Icons.account_box,
                    ),
                  ),
                  const CustomDivider(
                    symmetricPadding: 4,
                    dividerHeight: 4,
                    dividerThickness: 2,
                  ),
                  ListTile(
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    title: Text(AppLocalizations.of(context)!.cameraOption),
                    leading: const Icon(
                      Icons.camera,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //-----Picture-----
              Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                  child: InkWell(
                    onTap: () {
                      _showChoiceDialog(context);
                    },
                    child: Column(
                      children: [
                        Ink.image(
                          width: 175,
                          height: 175,
                          image: _image != null
                              ? Image.file(_image!).image
                              : const AssetImage(
                                  'assets/images/default_pick_image.png'),
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(_image != null
                              ? AppLocalizations.of(context)!.changeImage
                              : AppLocalizations.of(context)!.pickImage),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              //-----Restaurant Name-----
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomFormField(
                      controller: restaurantNameController,
                      labelText: AppLocalizations.of(context)!.restaurantName,
                      errorText: AppLocalizations.of(context)!
                          .enterRestaurantNameError,
                      prefixIcon: const Icon(Icons.restaurant),
                      readOnly: false,
                      validator: requiredString,
                      margin: const EdgeInsets.only(right: 16),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 62,
                    child: ElevatedButton(
                      onPressed: _selectCategories,
                      child: Text(
                        AppLocalizations.of(context)!.selectCategoriesButton,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              //-----Categories-----
              Container(
                margin: EdgeInsets.only(
                  top: _selectedCategories.isEmpty ? 4 : 12,
                ),
                child: Wrap(
                  spacing: 8,
                  children: _selectedCategories.map((category) {
                    return Chip(
                      label: Text(category),
                      onDeleted: () {
                        setState(() {
                          _selectedCategories.remove(category);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              //-----Location-----
              CustomFormField(
                controller: locationController,
                labelText: AppLocalizations.of(context)!.location,
                errorText: AppLocalizations.of(context)!.enterLocationError,
                prefixIcon: const Icon(Icons.location_on),
                readOnly: false,
                validator: requiredString,
                margin: const EdgeInsets.only(top: 12, bottom: 16),
              ),
              //-----Description-----
              CustomFormField(
                controller: descriptionController,
                labelText: AppLocalizations.of(context)!.description,
                errorText: AppLocalizations.of(context)!.enterDescriptionError,
                prefixIcon: const Icon(Icons.description),
                readOnly: false,
                validator: requiredString,
                margin: const EdgeInsets.only(bottom: 16),
              ),
              //-----Food Available-----
              CustomFormField(
                controller: foodAvailableController,
                labelText: AppLocalizations.of(context)!.foodAvailable,
                errorText:
                    AppLocalizations.of(context)!.enterFoodAvailableError,
                prefixIcon: const Icon(Icons.lunch_dining),
                readOnly: false,
                validator: requiredString,
                margin: const EdgeInsets.only(bottom: 16),
              ),
              //-----Rating-----
              Center(
                child: RatingBar.builder(
                    initialRating: _ratingController,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 10,
                    itemSize: 28,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _ratingController = rating;
                      });
                    }),
              ),
              const SizedBox(height: 16),
              //-----Additional Review-----
              CustomFormField(
                controller: reviewController,
                labelText: AppLocalizations.of(context)!.additionalReview,
                prefixIcon: const Icon(Icons.rate_review),
                readOnly: false,
                margin: const EdgeInsets.only(bottom: 16),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final restaurantName = restaurantNameController.value.text.trim();
            final location = locationController.value.text.trim();
            final description = descriptionController.value.text.trim();
            final foodAvailable =
                foodAvailableController.value.text.trim().split(',');
            final rating = _ratingController;
            final additionalReview = reviewController.value.text.trim();
            final selectedCategories = _selectedCategories;
            final createdTime = widget.review?.createdTime ?? DateTime.now();
            final isFavourite = widget.review?.isFavourite ?? false;
            Uint8List? imgString;
            if (_image != null) {
              imgString =
                  await resizeAndCompressImage(_image!.readAsBytesSync());
            } else if (widget.review?.image != null) {
              imgString = widget.review!.image;
            } else {
              imgString = null;
            }

            final Review newReview = Review(
              id: widget.review?.id,
              restaurantName: restaurantName,
              location: location,
              description: description,
              foodAvailable: foodAvailable,
              rating: rating,
              additionalReview: additionalReview,
              categories: selectedCategories,
              createdTime: createdTime,
              isFavourite: isFavourite,
              image: imgString,
            );
            if (widget.review == null) {
              await DatabaseService.addReview(newReview);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!.reviewAddedSnackbar,
                    style: const TextStyle(color: Colors.black)),
                backgroundColor: Colors.green[100],
              ));
            } else {
              await DatabaseService.updateReview(newReview);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    AppLocalizations.of(context)!.reviewUpdatedSnackbar,
                    style: const TextStyle(color: Colors.black)),
                backgroundColor: Colors.green[100],
              ));
            }
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
