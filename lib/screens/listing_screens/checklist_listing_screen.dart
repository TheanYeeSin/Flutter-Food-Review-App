import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/models/checklist_item.dart';
import 'package:foodreviewapp/widgets/checklist_item_widget.dart';
import 'package:foodreviewapp/widgets/form/checklist_item_from.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

// List all the checklist item screen
class ChecklistListingScreen extends StatefulWidget {
  const ChecklistListingScreen({super.key});

  @override
  State<ChecklistListingScreen> createState() => _ChecklistListingScreenState();
}

class _ChecklistListingScreenState extends State<ChecklistListingScreen> {
  bool isLoading = false;

  Future<List<ChecklistItem>?> _getAllChecklistItem() {
    return DatabaseService.getUncheckChecklistItem();
  }

  Future _refresh() async {
    setState(() {
      isLoading = true;
    });
    await _getAllChecklistItem();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.checklistTitle,
          style: const TextStyle(fontSize: 22),
        ),
      ),
      body: LiquidPullToRefresh(
        color: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        showChildOpacityTransition: false,
        onRefresh: () async {
          await _refresh();
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: FutureBuilder<List<ChecklistItem>?>(
                  future: _getAllChecklistItem(),
                  builder:
                      (context, AsyncSnapshot<List<ChecklistItem>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Something went wrong! Error: ${snapshot.error}',
                        ),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ChecklistItemWidget(
                            checklistItem: snapshot.data![index],
                            onLongPress: () async {
                              await _showAddChecklistDialog(
                                context,
                                snapshot.data![index],
                              );
                              setState(() {});
                            },
                            onDelete: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .deleteChecklistItemDialogTitle,
                                      ),
                                    ),
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .deleteChecklistItemDialogMessage,
                                    ),
                                    actions: [
                                      ButtonBar(
                                        alignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!.no,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await DatabaseService
                                                  .deleteChecklistItem(
                                                snapshot.data![index],
                                              );
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                              setState(() {});
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    // ignore: use_build_context_synchronously
                                                    AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .checklistItemDeletedSnackbar,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Colors.green[100],
                                                ),
                                              );
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!.yes,
                                              style: const TextStyle(
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    }
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noChecklistItemYet,
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showAddChecklistDialog(context, null);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> _showAddChecklistDialog(
  BuildContext context,
  ChecklistItem? checklistItem,
) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: ChecklistItemForm(
          checklistItem: checklistItem,
        ),
      );
    },
  );
}
