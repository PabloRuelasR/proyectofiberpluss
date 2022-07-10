import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectofiberpluss/src/pages/administrator/categories/create/administrator_categories_create_page.dart';
import 'package:proyectofiberpluss/src/pages/administrator/home/administrator_home_controller.dart';
import 'package:proyectofiberpluss/src/pages/administrator/orders/list/administrator_orders_list_page.dart';
import 'package:proyectofiberpluss/src/pages/administrator/products/create/administrator_products_create_page.dart';
import 'package:proyectofiberpluss/src/pages/client/home/client_home_controller.dart';
import 'package:proyectofiberpluss/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:proyectofiberpluss/src/pages/register/register_page.dart';
import 'package:proyectofiberpluss/src/pages/technician/orders/list/technician_orders_list_page.dart';
import 'package:proyectofiberpluss/src/utils/custom_animated_bottom_bar.dart';

class AdministratorHomePage extends StatelessWidget {

  AdministratorHomeController con = Get.put(AdministratorHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() =>IndexedStack(
          index: con.indexTab.value,
          children: [
          AdministratorOrdersListPage(),
          RegisterPage(),
          AdministratorCategoriesCreatePage(),
          AdministratorProductsCreatePage(),
          ClientProfileInfoPage()
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
            icon: Icon(Icons.list),
            title: Text('Pedidos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.person_add),
            title: Text('clientes'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.category),
            title: Text('categoria'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.wifi),
            title: Text('producto'),
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
