import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timepomodoro_app/core/theme/colors.dart';
import '../../features/time/presentation/pages/home_page.dart';
import '../routes/navigators.dart';
import '../routes/navigators_observes.dart';
import '../routes/page_generator.dart';

class MenuBottomPage extends StatefulWidget {
  const MenuBottomPage({super.key});

  static const routeName = '/menu';

  @override
  State<MenuBottomPage> createState() => _MenuBottomPageState();
}

class _MenuBottomPageState extends State<MenuBottomPage> {
  int _selectBottomTabIndex = 0;

  bool isvalid = false;

  final _controller = PageController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.jumpToPage(1);
      }
    });

    super.didChangeDependencies();
  }

  final pageBuilder = {
    0: PageClassGenerator().buildHomeTabPage,
    1: PageClassGenerator().buildProfileTabPage,
  };

  final navigators = {
    0: homeTabNavigator,
    1: profileTabNavigator,
  };

  final navigatorsObservers = {
    0: homeTabNavigatorObserver,
    1: profileTabNavigatorObserver,
  };

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: _handlerInternalNavigationInTab,
        child: Scaffold(
          extendBody: true,
          backgroundColor: lightBlackColor,
          body: _tab(context, _selectBottomTabIndex),
          bottomNavigationBar: bottomNavigationBar(),
        ));
  }

  Future<bool> _handlerInternalNavigationInTab() async {
    final popped =
        await navigators[_selectBottomTabIndex]!.currentState!.maybePop();
    return !popped;
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: lightBlackColor,
      selectedItemColor:Colors.white.withOpacity(0.5)
          , // Color del ícono y texto cuando está seleccionado
      unselectedItemColor: Colors.white.withOpacity(0.5),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      onTap: (index) {
        setState(() {
          _tabIconPressed(index);
        });
      },
      items: [
        _buildBottomNavigationBarItem(Icons.access_time, 'Pomodoro', 0),
        _buildBottomNavigationBarItem(Icons.person, 'Perfil', 1),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label, int isSelected) {
    return BottomNavigationBarItem(
      icon: Icon(icon,
          color: _selectBottomTabIndex == isSelected ? pinkColor : whiteColor),
      label: label,
      backgroundColor: lightBlackColor,
      activeIcon: Icon(icon,
          color: _selectBottomTabIndex == isSelected
              ? pinkColor
              : whiteColor), // Color del ícono cuando está seleccionado
    );
  }

  void _tabIconPressed(int index) {
    if (_selectBottomTabIndex != index) {
      setState(() {
        _selectBottomTabIndex = index;
      });

      if (index == 0) {
        navigators[index]
            ?.currentState
            ?.pushReplacementNamed(HomePage.routeName);
      }
    }
  }

  Widget _tab(BuildContext context, int tabIndex) {
    if (pageBuilder.containsKey(tabIndex)) {
      return CupertinoTabView(
        onGenerateRoute: pageBuilder[tabIndex],
        navigatorKey: navigators[tabIndex],
        navigatorObservers: [
          if (navigatorsObservers.containsKey(tabIndex))
            navigatorsObservers[tabIndex] as NavigatorObserver
        ],
      );
    } else {
      return const Material(
        child: Center(
          child: Text("Todavia no se ha aplicado"),
        ),
      );
    }
  }
}
