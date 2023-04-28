import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';
import 'package:hackthehike/Screens/profile_screen.dart';
import 'package:hackthehike/Screens/qr_code_screen.dart';
// import 'logo_list.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    Colors.green,
    Colors.yellowAccent,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: FrostedBottomBar(
        curve: Curves.easeInOut,

        bottom: 7,
        opacity: 0.5,
        sigmaX: 4,
        sigmaY: 4,
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 800),
        // hideOnScroll: true,
        body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: const [QRCodeScanner(), ProfileScreen()]),
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          controller: tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.green, width: 5),
            insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
          ),
          tabs: [
            TabsIcon(
                icons: Icons.qr_code,
                color: currentPage == 0 ? colors[0] : Colors.white),
            TabsIcon(
                icons: Icons.person,
                color: currentPage == 1 ? colors[1] : Colors.white),
          ],
        ),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final IconData icons;

  const TabsIcon(
      {Key? key,
      this.color = Colors.white,
      this.height = 60,
      this.width = 50,
      required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Icon(
          icons,
          color: color,
        ),
      ),
    );
  }
}
