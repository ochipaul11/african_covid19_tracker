import 'package:african_covid19_tracker/pages/account_page.dart';
import 'package:african_covid19_tracker/pages/countries_page.dart';
import 'package:african_covid19_tracker/pages/favorites_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    PageController _pageController = PageController();
    List<Widget> _screens = [GetCountriesData(), Favorites(), AccountPage()];
    void _onPageChanged(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    void _onItemTapped(int selectedIndex) {
      _pageController.jumpToPage(selectedIndex);
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
              backgroundColor: Colors.black12),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favorites',
              backgroundColor: Colors.black12),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Account',
            backgroundColor: Colors.black12,
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
