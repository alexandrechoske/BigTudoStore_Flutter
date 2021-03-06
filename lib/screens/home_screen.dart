import 'package:flutter/material.dart';
import 'package:projetoflutterv4/datas/cart_product.dart';
import 'package:projetoflutterv4/screens/category_screen.dart';
import 'package:projetoflutterv4/screens/favorites_screen.dart';
import 'package:projetoflutterv4/tabs/home_tab.dart';
import 'package:projetoflutterv4/tabs/orders_tab.dart';
import 'package:projetoflutterv4/tabs/places_tab.dart';
import 'package:projetoflutterv4/widgets/cart_button.dart';
import 'package:projetoflutterv4/widgets/custom_drawer.dart';

import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  //TODO: aqui altera as navegações do drawer

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Página Inicial"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: HomeTab(),
//          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductList(),
//          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meu Carrinho"),
            centerTitle: true,
          ),
          body: CartScreen(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Favoritos"),
            centerTitle: true,
          ),
          body: FavoriteScreen(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Sobre Big Tudo"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
