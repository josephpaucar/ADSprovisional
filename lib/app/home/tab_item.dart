import 'package:flutter/material.dart';
import '../../themes/custom_icons.dart/ads_custom_icons.dart';

enum TabItem { inicio, rutas, posts, servicios, cuenta }

class TabItemData {
  const TabItemData({required this.label, required this.icon});
  final String label;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.inicio: TabItemData(label: 'Inicio', icon: Icons.home_rounded),
    TabItem.rutas: TabItemData(label: 'Rutas', icon: Icons.directions_rounded),
    TabItem.posts: TabItemData(label: 'Posts', icon: AdsCustomIcons.birdIcon),
    TabItem.servicios:
        TabItemData(label: 'Servicios', icon: AdsCustomIcons.contacIcon),
    TabItem.cuenta: TabItemData(label: 'Cuenta', icon: Icons.person_rounded),
  };
}
