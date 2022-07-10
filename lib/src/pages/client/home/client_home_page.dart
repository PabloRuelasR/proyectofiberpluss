import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectofiberpluss/src/pages/administrator/orders/list/administrator_orders_list_page.dart';
import 'package:proyectofiberpluss/src/pages/client/home/client_home_controller.dart';
import 'package:proyectofiberpluss/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:proyectofiberpluss/src/pages/client/products/list/client_plan_list_page.dart';
import 'package:proyectofiberpluss/src/pages/client/products/list/client_products_list_page.dart';
import 'package:proyectofiberpluss/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:proyectofiberpluss/src/pages/technician/orders/list/technician_orders_list_page.dart';
import 'package:proyectofiberpluss/src/utils/custom_animated_bottom_bar.dart';

class ClientHomePage extends StatelessWidget {

  ClientHomeController con = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() =>IndexedStack(
          index: con.indexTab.value,
          children: [
            ClientProductsListPage(),
            ClientPlanListPage(),
            ClientOrdersListPage(),
            ClientProfileInfoPage(),
          ],
        ))
    );
  }

  Widget _bottomBar(){
    return Obx(()=>CustomAnimatedBottomBar(
      containerHeight: 50,
      backgroundColor: Colors.indigo,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Productos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Mi Plan'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Mis pedidos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
      ],
    )
    );
  }
}
