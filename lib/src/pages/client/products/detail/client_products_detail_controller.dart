import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyectofiberpluss/src/models/product.dart';

class ClientProductsDetailController extends GetxController {

  List<Product> selectedProducts = [];

  void checkIfProductsWasAddes(Product product, var price, var counter) {
    price.value = product.price ?? 0.0;

    if (GetStorage().read('shopping_bag') != null){

      if (GetStorage().read('shopping_bag') is List<Product>) {
        selectedProducts = (GetStorage().read('shopping_bag'));
      }
      else {
        selectedProducts = Product.fromJsonList(GetStorage().read('shopping_bag'));
      }
      int index = selectedProducts.indexWhere((p) => p.id == product.id);

      if(index != -1 ) {
        counter.value = selectedProducts[index].quantity!;
        price.value = product.price! * counter.value;
        }
      }
    }


  void addToBag(Product product, var price, var counter){

    if (counter.value > 0) {
      int index = selectedProducts.indexWhere((p) => p.id == product.id);

      if (index == -1) {
        if (product.quantity == null) {
          if (counter.value > 0) {
            product.quantity =counter.value;
          }
          else {
            product.quantity = 1;
          }
        }

        selectedProducts.add(product);
      }
      else {
        selectedProducts[index].quantity = counter.value;
      }

      GetStorage().write('shopping_bag', selectedProducts);
      Fluttertoast.showToast(msg: 'Producto agregado');
    }
    else {
      Fluttertoast.showToast(msg: 'Debes seleccionar al menos un item para agregar');
    }

  }

  void addItem(Product product, var price, var counter) {
    counter.value = counter.value + 1;
    price.value = product.price! * counter.value;
  }

  void removeItem(Product product, var price, var counter) {
    if (counter.value > 0) {
      counter.value = counter.value - 1;
      print('PRODUCTO AGREGADO: ${product.toJson()}');
      price.value = product.price! * counter.value;
    }
  }
}
