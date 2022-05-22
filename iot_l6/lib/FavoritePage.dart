import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './product.dart';
import './main.dart';
import './ProductPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;
class FavoritePage extends StatefulWidget {
  FavoritePage(this.shoppingCart, this.favourites) : super();

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
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final TextEditingController textFieldController = TextEditingController();
  int _selectedPage = 2;

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
        title: Text('Favorites'),
        actions: [
          IconButton(onPressed: (){backupFavs();}, icon: Icon(Icons.cloud_upload)),
          IconButton(onPressed: (){restoreFavs();}, icon: Icon(Icons.cloud_download)),
        ],
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
                  Text(
                    "Product listed as Favorite :",
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
                  itemCount: widget.favourites.length,
                  itemBuilder: (context, index) {
                    final product = widget.favourites[index].name;
                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                        key: Key(product),
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                            print('Remove item');
                            setState(() {
                              widget.favourites.removeAt(index);
                            });
                          // Remove the item from the data source.
                          // Then show a snackbar.
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('$product dismissed')));
                        },
                        // Show a red background as the item is swiped away.
                        background:Container(color: Colors.red),
                        child :  ShoppingListItem(
                          product: widget.favourites[index],
                          inCart: widget.favourites.contains(widget.favourites[index]),
                          onCartChanged: onCartChanged,
                        ));
                  }),
            )
          ],
        ),
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

  void onCartChanged(Product product, bool inCart) {
    setState(() {
      // if (!inCart) shoppingCart.add(product);
      widget.favourites.remove(product);
    });
  }

  void backupFavs() async {
    var uid = _auth.currentUser.uid;
    if(_auth.currentUser != null){
      var collection = db.collection('users/$uid/favs');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }

      widget.favourites.forEach((element) async {await db.collection('users/$uid/favs').add(element.toJson());});
    }
  }

  void restoreFavs() async {
    var uid = _auth.currentUser.uid;
    if(_auth.currentUser != null) {
      var collection = db.collection('users/$uid/favs');
      var snapshots = await collection.get();

      setState(() {
        widget.favourites.clear();
        for (var doc in snapshots.docs) {
          widget.favourites.add(Product.fromJson(doc.data()));
        }
      });
      }
    }
  }





