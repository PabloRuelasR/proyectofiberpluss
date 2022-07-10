import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyectofiberpluss/src/models/product.dart';
import 'package:proyectofiberpluss/src/pages/client/products/detail/client_products_detail_controller.dart';
import '../../../../models/user.dart';
import '../list/client_plan_list_controller.dart';

class ClientPlanDetailPage extends StatelessWidget {

  ClientPlanListController conn = Get.put(ClientPlanListController());


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(245, 245, 245, 1.0),
        height: 100,
          child: _buttonAddToBag()
      ),
      body: Column(
        children: [
          _imageSlideshow(context),
          _textNameProduct(),
          _textDescriptionProduct(),
          _textPriceProduct()
        ],
      ),
     )
    );
  }

  Widget _textNameProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
          conn.user.value.plan.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black
          ),
      ),
    );
  }

  Widget _textDescriptionProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        "Ingrese para pagar su recibo",
        style: TextStyle(
            fontSize: 16,
        ),
      ),
    );
  }

  Widget _buttonAddToBag() {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 25),
          child: Row(
            children: [
               ElevatedButton(
                onPressed: (null),
                child: Text(
                  'Pagar  S/${conn.user.value.precio}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    )
                ),
              ),
            ],
          )
        )
       /* Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 25),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => con.removeItem(),
                child: Text(
                  '-',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(45, 37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        )
                    )
                ),
              ),
              /*
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '${con.counter.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(40, 37)
                ),
              ),
              ElevatedButton(
                onPressed: () => con.addItem(),
                child: Text(
                  '+',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(45, 37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )
                    )
                ),
              ),*/
              Spacer(),
              ElevatedButton(
                onPressed: () => con.addToBag(),
                child: Text(
                  'Agregar  S/${con.price.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    )
                ),
              ),
            ],
          ),
        )*/
      ],
    );
  }

  Widget _textPriceProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        '\S/${conn.user.value.precio?? ''}',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

 Widget _imageSlideshow(BuildContext context) {
    return ImageSlideshow(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        initialPage: 0,
        indicatorColor: Colors.indigo,
        indicatorBackgroundColor: Colors.grey,
        children: [
          FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
              image: AssetImage('assets/img/no-image.png')
          ),
          FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
              image: AssetImage('assets/img/no-image.png')
          ),
          FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
              image: AssetImage('assets/img/no-image.png')
          ),
                 ]
    );
  }

}
