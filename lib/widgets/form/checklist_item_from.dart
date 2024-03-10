import 'package:flutter/material.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/models/checklist_item.dart';
import 'package:foodreviewapp/utils/validator.dart';
import 'package:foodreviewapp/widgets/common/custom_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistItemForm extends StatefulWidget {
  final ChecklistItem? checklistItem;
  const ChecklistItemForm({super.key, this.checklistItem});

  @override
  State<ChecklistItemForm> createState() => _ChecklistItemFormState();
}

class _ChecklistItemFormState extends State<ChecklistItemForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadChecklistItemData();
  }

  _loadChecklistItemData() {
    if (widget.checklistItem != null) {
      nameController.text = widget.checklistItem!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          right: 10,
          left: 10,
          top: 10),
      child: Column(
        children: [
          Text(
            widget.checklistItem == null
                ? AppLocalizations.of(context)!.addChecklistItemTitle
                : AppLocalizations.of(context)!.editChecklistItemTitle,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomFormField(
                  controller: nameController,
                  labelText: AppLocalizations.of(context)!.checklistItem,
                  errorText:
                      AppLocalizations.of(context)!.enterChecklistItemNameError,
                  prefixIcon: const Icon(Icons.add_box_outlined),
                  validator: requiredString,
                  readOnly: false,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final name = nameController.value.text.trim();
                        final isChecked =
                            widget.checklistItem?.isChecked ?? false;

                        final ChecklistItem newChecklistItem = ChecklistItem(
                            id: widget.checklistItem?.id,
                            name: name,
                            isChecked: isChecked);
                        if (widget.checklistItem == null) {
                          await DatabaseService.addChecklistItem(
                              newChecklistItem);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                AppLocalizations.of(context)!
                                    .checklistItemAddedSnackbar,
                                style: const TextStyle(color: Colors.black)),
                            backgroundColor: Colors.green[100],
                          ));
                        } else {
                          await DatabaseService.updateChecklistItem(
                              newChecklistItem);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                AppLocalizations.of(context)!
                                    .checklistItemUpdatedSnackbar,
                                style: const TextStyle(color: Colors.black)),
                            backgroundColor: Colors.green[100],
                          ));
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
