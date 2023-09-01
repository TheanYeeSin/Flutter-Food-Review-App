import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/more_screen.dart';
import 'package:foodreviewapp/screens/listing_screens/main_listing_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
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
        _selectedIndex = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _children = [
    const MainListingScreen(),
    const MoreScreen()
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
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
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
        backgroundColor: colorScheme.surface,
        selectedFontSize: 15,
        selectedItemColor: colorScheme.onSurface,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        onTap: _onItemTapped,
      ),
    );
  }
}
