import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:streakup/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .outline, // or any color you want
              width: 1, // thickness of the top border
            ),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 6),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash
                .splashFactory, // 🚫 Disables ripple entirely to maintain a clean and minimalistic UI for the bottom navigation bar, ensuring no visual distractions when tapping.
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: _page,
            onTap: navigationTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface,
            selectedLabelStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/House_01.svg',
                    // ignore: deprecated_member_use
                    color: _page == 0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    width: 30,
                    height: 30,
                  ),
                  label: 'Home',
                  backgroundColor: Theme.of(context).colorScheme.onSurface),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/Calendar.svg',
                    // ignore: deprecated_member_use
                    color: _page == 1
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    width: 30,
                    height: 30,
                  ),
                  label: 'Appointments',
                  backgroundColor: Theme.of(context).colorScheme.onSurface),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/File_Blank.svg',
                    // ignore: deprecated_member_use
                    color: _page == 2
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    width: 30,
                    height: 30,
                  ),
                  label: 'Health Records',
                  backgroundColor: Theme.of(context).colorScheme.onSurface),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/UserAvatar.svg',
                    // ignore: deprecated_member_use
                    color: _page == 3
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    width: 30,
                    height: 30,
                  ),
                  label: 'Account',
                  backgroundColor: Theme.of(context).colorScheme.onSurface),
            ],
          ),
        ),
      ),
    );
  }
}
