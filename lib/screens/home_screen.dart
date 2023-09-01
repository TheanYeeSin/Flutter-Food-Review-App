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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: _children[_selectedIndex],
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
