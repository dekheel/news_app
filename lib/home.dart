import 'package:flutter/material.dart';
import 'package:news_app/theme/my_theme.dart';

class HomePage extends StatelessWidget {
  static const String initialRoute = "homePage";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Image.asset("assets/pattern.png", fit: BoxFit.cover),
      ),
      Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Text("News App"),
        ),
        backgroundColor: Colors.transparent,
      )
    ]);
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationDrawer(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .12,
            color: MyTheme.primaryColor,
            child: Center(
                child: Text(
              "News App!",
              style: Theme.of(context).textTheme.titleLarge,
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          DrawerItem(icon: Icons.view_list, title: "Categories", onTap: () {}),
          const SizedBox(
            height: 20,
          ),
          DrawerItem(icon: Icons.settings, title: "Settings", onTap: () {}),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const DrawerItem(
      {required this.onTap,
      required this.icon,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Icon(
            icon,
            color: MyTheme.blackColor,
            size: 35,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: MyTheme.blackColor,
                ),
          )
        ],
      ),
    );
  }
}
