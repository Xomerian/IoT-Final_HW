import 'package:flutter/material.dart';
import 'package:l5_iot/product.dart';

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final inCart;
  final Function(Product product, bool inCart) onCartChanged;

  ShoppingListItem({
    @required this.product,
    @required this.inCart,
    @required this.onCartChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      leading: CircleAvatar(
        backgroundColor: Colors.amber,
        child: Text(product.name[0]),
      ),
      onTap: () {
        onCartChanged(product, inCart);
      },
    );
  }
}
