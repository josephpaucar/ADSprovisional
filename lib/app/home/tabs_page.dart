import 'package:aves_de_san_martin/app/home/cupertino_tabs_scaffold.dart';
import 'package:aves_de_san_martin/app/home/posts/posts_page.dart';
import 'package:aves_de_san_martin/app/home/profile/profile_page.dart';
import 'package:aves_de_san_martin/app/home/rutas/rutas_page.dart';
import 'package:aves_de_san_martin/app/home/servicios/services_page.dart';
import 'package:aves_de_san_martin/app/home/tab_item.dart';
import 'package:flutter/material.dart';

import 'inicio/home_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  TabItem _currentTab = TabItem.inicio;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.inicio: GlobalKey<NavigatorState>(),
    TabItem.rutas: GlobalKey<NavigatorState>(),
    TabItem.posts: GlobalKey<NavigatorState>(),
    TabItem.servicios: GlobalKey<NavigatorState>(),
    TabItem.cuenta: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.inicio: (context) => const HomePage(),
      TabItem.rutas: (context) => const RutasPage(),
      TabItem.posts: (context) => PostsPage(),
      TabItem.servicios: (context) => const ServicesPage(),
      TabItem.cuenta: (context) => ProfilePage(),
    };
  }

  void _select(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoTabsScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
