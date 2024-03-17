import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/listing_screens/checklist_listing_screen.dart';
import 'package:foodreviewapp/screens/more_screen.dart';
import 'package:foodreviewapp/screens/listing_screens/main_listing_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Navigate between different screen on main page
class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({super.key});

  @override
  State<ScreenNavigator> createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  int _selectedIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      return;
    }
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _selectedIndex = _pageController.page?.round() ?? 1;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _children = [
    const ChecklistListingScreen(),
    const MainListingScreen(),
    const MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTapped,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.checklist_rounded),
            label: AppLocalizations.of(context)!.checklistNavBar,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.reviews),
            label: AppLocalizations.of(context)!.reviewNavBar,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.more_horiz),
            label: AppLocalizations.of(context)!.moreNavBar,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 17,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        onTap: _onItemTapped,
      ),
    );
  }
}
