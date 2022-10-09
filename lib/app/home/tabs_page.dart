import 'package:aves_de_san_martin/app/home/cupertino_tabs_scaffold.dart';
import 'package:aves_de_san_martin/app/home/tab_item.dart';
import 'package:aves_de_san_martin/pages/pages.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  TabItem _currentTab = TabItem.inicio;

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
    return CupertinoTabsScaffold(
      currentTab: _currentTab,
      onSelectTab: _select,
      widgetBuilders: widgetBuilders,
    );
  }
}
