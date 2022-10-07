import 'package:aves_de_san_martin/app/home/tab_item.dart';
import 'package:aves_de_san_martin/themes/tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTabsScaffold extends StatelessWidget {
  const CupertinoTabsScaffold(
      {super.key,
      required this.currentTab,
      required this.onSelectTab,
      required this.widgetBuilders});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.inicio),
          _buildItem(TabItem.rutas),
          _buildItem(TabItem.posts),
          _buildItem(TabItem.servicios),
          _buildItem(TabItem.cuenta),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (BuildContext context, int index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          builder: (context) => widgetBuilders[item]!(context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color =
        currentTab == tabItem ? lightColorScheme.secondary : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData!.icon,
        color: color,
      ),
      label: itemData.label,
    );
  }
}
