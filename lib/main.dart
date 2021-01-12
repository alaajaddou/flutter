import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Item {
  final int id;
  final String title;

  Item({this.id, this.title});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
    );
  }
}

class Category {
  final int id;
  final String title;
  final String image;
  List<Item> items = [];

  Category({this.id, this.title, this.image});

  fillItems(items) {
    this.items = items;
  }

  factory Category.fromJson(Map json) {
    return Category(
        id: json['userId'],
        title: json['name'],
        image: json['image']
            ? 'http://wooow-super.com/storage/${json['image']}'
            : null);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var categories = [];

  @override
  void initState() {
    super.initState();
  }

  _fetchCategories() async {
    final url = 'https://wooow-super.com/api/categories';
    final response = await http.get(url);
    setState(() {
      categories = jsonDecode(response.body)['categories'];
    });
  }

  List<Widget> getSmallCategoriesList() {
    List<Widget> widgets = [];
    for (var i = 0; i < categories.length; i++) {
      widgets.add(Container(
        width: 100,
        color: const Color(0xEEEEEEEE),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage('http://wooow-super.com/storage/${categories[i]['image']}'),
                    fit: BoxFit.fill),
              ),
            ),
            Text(categories[i]['name'] != null ? categories[i]['name'] : 'none')
          ],
        ),
      ));
    }
    return widgets;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Categories',
      style: optionStyle,
    ),
    Text(
      'Index 2: Cart',
      style: optionStyle,
    ),
    Text(
      'Index 3: Orders',
      style: optionStyle,
    ),
    Text(
      'Index 4: Wishlist',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    onPressed() => {};
    showAccount() => {};
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.add_alert), onPressed: onPressed),
          IconButton(icon: const Icon(Icons.person_pin), onPressed: showAccount)
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debugdebug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5.0),
              color: Theme
                  .of(context)
                  .primaryColor,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                'https://www.indiacreatives.in/images/image_services/Banner-Designing-Services1.jpg',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            Container(
                width: double.infinity,
                height: 100,

                child: FutureBuilder<dynamic>(
                    future: _fetchCategories(),
                    // a previously-obtained Future<String> or null
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      List<Widget> children = getSmallCategoriesList();
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        children: children,
                      );
                    }
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.amber[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
