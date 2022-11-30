import 'package:flutter/material.dart';
import 'package:marketing_tools/Screens/screen_three.dart';
import 'package:marketing_tools/Screens/screen_two.dart';
import 'package:marketing_tools/screens/widget_test.dart';

import 'Screens/screen_four.dart';
import 'screens/ScreenZero.dart';

class TabsMenu extends StatefulWidget {
  const TabsMenu({Key? key}) : super(key: key);

  @override
  State<TabsMenu> createState() => _TabsMenuState();
}

class _TabsMenuState extends State<TabsMenu> {
  int _selectedPageIndex = 0;

  final PageController _pageController = PageController();

  static const List<String> _pagesTitles = [
    'Screen 0',
    'Screen 1',
    'Screen 2',
    'Tego puba nie używamy',
    'Widgets Test'
  ];

  void _selectedPage(int selectedIndex) {
    //context.read<TabsProvider>().changeTab(selectedIndex);
    _pageController.jumpToPage(selectedIndex);
  }

  void _onPageChanged(int index) {
    _selectedPageIndex = index;
    setState(() {});
  }

  late final List<Widget> _listItems = [
    const NavigationDestination(
      //selectedIcon: _icon(Assets.ASSETS_MENU_ICONS_MENU_SELECTED_SVG, isSelected: true),
        selectedIcon: Icon(Icons.account_circle),
        icon: Icon(Icons.account_circle_outlined),
        label: 'Zero'),
    const NavigationDestination(
      //selectedIcon: _icon(Assets.ASSETS_MENU_ICONS_MENU_SELECTED_SVG, isSelected: true),
        selectedIcon: Icon(Icons.account_circle),
        icon: Icon(Icons.account_circle_outlined),
        label: 'One'),
    const NavigationDestination(
      //selectedIcon: _icon(Assets.ASSETS_MENU_ICONS_MENU_SELECTED_SVG, isSelected: true),
        selectedIcon: Icon(Icons.account_circle),
        icon: Icon(Icons.account_circle_outlined),
        label: 'Two'),
    const NavigationDestination(
      //selectedIcon: _icon(Assets.ASSETS_MENU_ICONS_MENU_SELECTED_SVG, isSelected: true),
        selectedIcon: Icon(Icons.account_circle),
        icon: Icon(Icons.account_circle_outlined),
        label: 'Three'),
    const NavigationDestination(
      //selectedIcon: _icon(Assets.ASSETS_MENU_ICONS_MENU_SELECTED_SVG, isSelected: true),
        selectedIcon: Icon(Icons.account_circle),
        icon: Icon(Icons.account_circle_outlined),
        label: 'Widgets'),
  ];

  final List<Widget> _screens = [
     ScreenZero(),
    const ScreenFour(),
    const ScreenThree(),
    const ScreenTwo(),
    const WidgetTest()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //rawer: AppDrawer(),
      appBar: AppBar(

        /*leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding:  const EdgeInsets.fromLTRB(14, 1, 0, 0),
              alignment: Alignment.centerLeft,
              icon: _icon(Assets.ASSETS_MENU_ICONS_DRAWER_ICON_SVG),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),*/

        elevation: 0.0,
        backgroundColor: Colors.white,
        title: _selectedPageIndex == 0 || _selectedPageIndex == 1
            ? const Padding(
          padding:  EdgeInsets.only(right: 50), // Przesunięcie logo FOGEES w lewo
          child: Center(
            //child: SvgPicture.asset(Assets.ASSETS_IMAGES_FOGEES_HORIZONTAL_SVG,
            child: Icon(
              Icons.account_circle
            ),
               ),
        )
            : Text(
         _pagesTitles[_selectedPageIndex],
          //style: const TextStyle(color: AppConsts.accentColor),
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            //indicatorColor: AppConsts.menuIndicatorColor,
            indicatorColor: Colors.amber,
            labelTextStyle: MaterialStateProperty.all(
              /// Font pod ikonami w TABS
              const TextStyle(
                  fontSize: 11,
                  //letterSpacing: -0.1,
                  fontWeight: FontWeight.w400),
            ),
          ),
          child: NavigationBar(
            backgroundColor: Colors.white,
            //height: 40,
            height: 58,

            animationDuration: const Duration(seconds: 1),
            selectedIndex: _selectedPageIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (index) => _selectedPage(index),
            destinations: _listItems,
          )),
      body: Stack(
          children:
          [PageView(
            controller: _pageController,
            children: _screens,
            onPageChanged: _onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
          ),
            //if (_connectionStatus == ConnectivityResult.none) Container(color: Colors.black.withOpacity(0.5)),
            //if (_connectionStatus == ConnectivityResult.none) Center(child: noInternetConnection()),
          ]),
      /*body: SafeArea(
            child: _pages[_selectedPageIndex]['page'] as Widget
        )*/
    );
  }
}
