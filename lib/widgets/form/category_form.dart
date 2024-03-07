import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodreviewapp/models/category.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/utils/validator.dart';
import 'package:foodreviewapp/widgets/common/custom_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/utils/image.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;
  const CategoryForm({super.key, this.category});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  final categoryDescriptionController = TextEditingController();
  String? oldCategoryName;
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadCategoryData();
  }

  _loadCategoryData() async {
    if (widget.category != null) {
      categoryNameController.text = widget.category!.name;
      oldCategoryName = widget.category!.name;
      categoryDescriptionController.text = widget.category!.description;
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
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

  Future<void> _updateReviewCategory(
      String categoryName, String updatedCategoryName) async {
    List<Review>? reviews =
        await DatabaseService.getReviewsByColumn('categories', categoryName);
    for (Review review in reviews!) {
      review.categories?.remove(categoryName);
      review.categories?.add(updatedCategoryName);
      await DatabaseService.updateReview(review);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //-----Category Name-----
              CustomFormField(
                controller: categoryNameController,
                labelText: AppLocalizations.of(context)!.categoryName,
                errorText: AppLocalizations.of(context)!.enterCategoryNameError,
                prefixIcon: const Icon(Icons.catching_pokemon_outlined),
                readOnly: false,
                validator: requiredString,
                margin: const EdgeInsets.only(bottom: 16),
              ),
              //-----Category Description-----
              CustomFormField(
                controller: categoryDescriptionController,
                labelText: AppLocalizations.of(context)!.categoryDescription,
                errorText:
                    AppLocalizations.of(context)!.enterCategoryDescriptionError,
                prefixIcon: const Icon(Icons.description_outlined),
                readOnly: false,
                validator: requiredString,
                margin: const EdgeInsets.only(bottom: 16),
              ),
              _image == null
                  ? ElevatedButton(
                      onPressed: pickImage,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                          children: [
                            const Icon(Icons.image),
                            const SizedBox(width: 10),
                            Text(
                              widget.category == null
                                  ? AppLocalizations.of(context)!
                                      .uploadCategoryImage
                                  : AppLocalizations.of(context)!
                                      .updateCategoryImage,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: pickImage,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                          children: [
                            const Icon(Icons.image),
                            const SizedBox(width: 10),
                            Text(
                              AppLocalizations.of(context)!
                                  .categoryImageUploaded,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              if (_image != null) ...[
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    width: double.infinity,
                    height: 200,
                    child: Image.file(_image!)),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final name = categoryNameController.value.text.trim();
            final description = categoryDescriptionController.value.text.trim();
            Uint8List? imgString;
            if (_image != null) {
              imgString =
                  await resizeAndCompressImage(_image!.readAsBytesSync());
            } else if (widget.category?.image != null) {
              imgString = widget.category!.image;
            } else {
              imgString = null;
            }
            final Category newCategory = Category(
              id: widget.category?.id,
              name: name,
              description: description,
              image: imgString,
            );
            if (widget.category == null) {
              await DatabaseService.addCategory(newCategory);
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                // ignore: use_build_context_synchronously
                content: Text(
                    AppLocalizations.of(context)!.categoryAddedSnackbar,
                    style: const TextStyle(color: Colors.black)),
                backgroundColor: Colors.green[100],
              ));
            } else {
              _updateReviewCategory(oldCategoryName!, name);
              await DatabaseService.updateCategory(newCategory);
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                // ignore: use_build_context_synchronously
                content: Text(
                    AppLocalizations.of(context)!.categoryUpdatedSnackbar,
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
