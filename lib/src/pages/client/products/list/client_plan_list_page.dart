import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectofiberpluss/src/models/category.dart';
import 'package:proyectofiberpluss/src/models/product.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/pages/administrator/orders/list/administrator_orders_list_page.dart';
import 'package:proyectofiberpluss/src/pages/client/products/list/client_products_list_controller.dart';

import 'package:proyectofiberpluss/src/pages/register/register_page.dart';
import 'package:proyectofiberpluss/src/pages/technician/orders/list/technician_orders_list_page.dart';
import 'package:proyectofiberpluss/src/utils/custom_animated_bottom_bar.dart';
import 'package:proyectofiberpluss/src/widgets/no_data_widget.dart';

import 'client_plan_list_controller.dart';

class ClientPlanListPage extends StatelessWidget {

  ClientPlanListController conn = Get.put(ClientPlanListController());
  ClientProductsListController con = Get.put(ClientProductsListController());

  final List<Tab> plan = <Tab>[
    Tab(text: 'Mi plan',)
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
        length: plan.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
              child: AppBar(
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.indigo,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[600],
                  tabs: List<Widget>.generate(plan.length, (index) {
                    return Tab(
                      child: Text('Mi plan'),
                    );
                  }),
                ),
              ),
          ),
        body: TabBarView(
            children: [            
                _cardProduct(context)      
            ]
          )
        ),
     )
    );
  }

Widget _cardProduct(BuildContext context ) {
  return GestureDetector(
    onTap: () => conn.openBottomSheet(context),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, left: 20, right: 20),
          child: ListTile(
            title: Text(conn.user.value.plan.toString()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                    conn.user.value.lastname ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13
                    ),
                ),
                SizedBox(height: 15),
                Text(
                    '\S/${conn.user.value.precio}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                ),
                SizedBox(height: 20),
              ],
            ),
            trailing: Container(
              height: 70,
              width: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  image: AssetImage('assets/img/logofiber.png') as ImageProvider,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/logofiber.png'),
                  ),
              ),
            ),
          ),
        ),
        Divider(height: 1, color: Colors.grey[400], indent: 40, endIndent: 37,)
      ],
    ),
  );
  }
}
