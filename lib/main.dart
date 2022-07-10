import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/pages/administrator/home/administrator_home_page.dart';
import 'package:proyectofiberpluss/src/pages/administrator/orders/detail/administrator_orders_detail_page.dart';
import 'package:proyectofiberpluss/src/pages/administrator/orders/list/administrator_orders_list_page.dart';
import 'package:proyectofiberpluss/src/pages/client/address/create/client_address_create_page.dart';
import 'package:proyectofiberpluss/src/pages/client/address/list/client_address_list_page.dart';
import 'package:proyectofiberpluss/src/pages/client/home/client_home_page.dart';
import 'package:proyectofiberpluss/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:proyectofiberpluss/src/pages/client/orders/detail/client_orders_detail_page.dart';
import 'package:proyectofiberpluss/src/pages/client/orders/map/client_orders_map_page.dart';
import 'package:proyectofiberpluss/src/pages/client/payments/create/client_payments_create_page.dart';
import 'package:proyectofiberpluss/src/pages/client/payments/installments/client_payments_installments_page.dart';
import 'package:proyectofiberpluss/src/pages/client/payments/status/client_payments_status_page.dart';
import 'package:proyectofiberpluss/src/pages/client/products/list/client_products_list_page.dart';
import 'package:proyectofiberpluss/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:proyectofiberpluss/src/pages/home/home_page.dart';
import 'package:proyectofiberpluss/src/pages/login/login_page.dart';
import 'package:proyectofiberpluss/src/pages/register/register_page.dart';
import 'package:proyectofiberpluss/src/pages/technician/home/technician_home_page.dart';
import 'package:proyectofiberpluss/src/pages/technician/orders/detail/technician_orders_detail_page.dart';
import 'package:proyectofiberpluss/src/pages/technician/orders/list/technician_orders_list_page.dart';
import 'package:proyectofiberpluss/src/pages/technician/orders/map/technician_orders_map_page.dart';
import 'package:proyectofiberpluss/src/providers/push_notifications_provider.dart';
import 'package:proyectofiberpluss/src/roles/roles_page.dart';
import 'package:proyectofiberpluss/src/utils/firebase_config.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});
PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: FirebaseConfig.currentPlatform);
  print('Recibiendo notificaciones en segundo plano ${message.messageId}');
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseConfig.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initPushNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
    print('EL TOKEN DE SESION DEL USUARIO: ${userSession.sessionToken}');
    pushNotificationsProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    print('Usuario id: ${userSession.id}');

    return GetMaterialApp(
      title: 'Fiber +',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id !=null ? userSession.roles!.length > 1 ? '/roles' : '/client/home' : '/',
      getPages: [
        GetPage(name: '/', page:() =>LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
        GetPage(name: '/administrator/home', page: () => AdministratorHomePage()),
        GetPage(name: '/administrator/orders/list', page: () => AdministratorOrdersListPage()),
        GetPage(name: '/administrator/orders/detail', page: () => AdministratorOrdersDetailPage()),
        GetPage(name: '/technician/orders/list', page: () => TechnicianOrdersListPage()),
        GetPage(name: '/technician/orders/detail', page: () => TechnicianOrdersDetailPage()),
        GetPage(name: '/technician/orders/map', page: () => TechnicianOrdersMapPage()),
        GetPage(name: '/technician/home', page: () => TechnicianHomePage()),
        GetPage(name: '/client/home', page: () => ClientHomePage()),
        GetPage(name: '/client/products/list', page: () => ClientProductsListPage()),
        GetPage(name: '/client/profile/info', page: () => ClientProfileInfoPage()),
        GetPage(name: '/client/profile/update', page: () => ClientProfileInfoPage()),
        GetPage(name: '/client/orders/create', page: () => ClientOrdersCreatePage()),
        GetPage(name: '/client/orders/detail', page: () => ClientOrdersDetailPage()),
        GetPage(name: '/client/orders/map', page: () => ClientOrdersMapPage()),
        GetPage(name: '/client/address/create', page: () => ClientAddressCreatePage()),
        GetPage(name: '/client/address/list', page: () => ClientAddressListPage()),
        GetPage(name: '/client/payments/create', page: () => ClientPaymentsCreatePage()),
        GetPage(name: '/client/payments/installments', page: () => ClientPaymentsInstallmentsPage()),
        GetPage(name: '/client/payments/status', page: () => ClientPaymentsStatusPage()),
      ],
      theme: ThemeData(
          primaryColor: Colors.indigo,
          colorScheme: ColorScheme(
              primary: Colors.indigo,
              secondary: Colors.indigo,
              brightness: Brightness.light,
              onBackground: Colors.grey,
              onPrimary: Colors.grey,
              surface: Colors.grey,
              onSurface: Colors.grey,
              error: Colors.grey,
              onError: Colors.grey,
              onSecondary: Colors.grey,
              background: Colors.grey
          )
      ),
      navigatorKey: Get.key,
    );

  }
}
