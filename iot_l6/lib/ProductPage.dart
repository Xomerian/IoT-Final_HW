import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './product.dart';
import './main.dart';
import './FavoritePage.dart';

class ProductPage extends StatefulWidget {
  ProductPage(this.shoppingCart, this.favourites) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final List<Product> shoppingCart;
  final List<Product> favourites;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  int _selectedPage = 1;
  Color col = Colors.red;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Product List'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    "assets/toDo.png",
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    "Products you have to buy",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.shoppingCart.length,
                  itemBuilder: (context, index) {
                    final product = widget.shoppingCart[index].name;
                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                        key: Key(product),
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            print("Add to favorite");
                            setState(() {
                              widget.favourites.add(widget.shoppingCart[index]);
                              widget.shoppingCart.removeAt(index);
                              col = Colors.green;
                            });
                          } else {
                            print('Remove item');
                            setState(() {
                              widget.shoppingCart.removeAt(index);
                              col = Colors.red;
                            });
                          }
                          // Remove the item from the data source.


                          // Then show a snackbar.
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('$product dismissed')));
                        },
                        // Show a red background as the item is swiped away.
                        background:Container(color: col),
                        child :  ShoppingListItem(
                          product: widget.shoppingCart[index],
                          inCart: widget.shoppingCart.contains(widget.shoppingCart[index]),
                          onCartChanged: onCartChanged,
                        ));
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayDialog(context),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color : Colors.black),
            label: 'HomePage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list,color : Colors.black),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color : Colors.black),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
    if(index==0) _navigateToHomePage(context);
    else if(index==1) _navigateToProductPage(context);
    else _navigateToFavoritePage(context);
  }
  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AuthTypeSelector(widget.shoppingCart,widget.favourites)));
  }
  void _navigateToProductPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProductPage(widget.shoppingCart,widget.favourites)));
  }
  void _navigateToFavoritePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FavoritePage(widget.shoppingCart,widget.favourites)));
  }

  Future<AlertDialog> displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Add a new product to your list",
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                Text('Name :'),
                TextField(
                  controller: nameController,
                ),
                Text('Price :'),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                Text('Quantity :'),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                Text('Description :'),
                TextField(
                  controller: descController,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // print(textFieldController.text);
                  if (nameController.text.trim() != "" && priceController.text.trim() != "" && quantityController.text.trim() != "" && descController.text.trim() != "")
                    setState(() {
                      widget.shoppingCart.add(Product(name: nameController.text,price: int.parse(priceController.text),quantity: int.parse(quantityController.text),description: descController.text));
                    });

                  nameController.clear();
                  Navigator.of(context).pop();
                },
                child: Text("save"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        });
  }

  void onCartChanged(Product product, bool inCart) {
    setState(() {
      // if (!inCart) shoppingCart.add(product);
      widget.shoppingCart.remove(product);
    });
  }
}
