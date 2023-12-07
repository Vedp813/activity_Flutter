import 'package:activity/Screens/location.dart';
import 'package:activity/Widgets/prefind.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    PreFind(),
    Text(
      'Edit Profile',
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
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.black,
              child: const SizedBox(
                height: 180,
                child: DrawerHeader(
                  // margin: EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    // image: DecorationImage(
                    //   alignment: Alignment.bottomCenter,
                    //   scale: 13,
                    //   image: AssetImage('assets/redwhale_logo.jpg'),
                    //   //fit: BoxFit.values
                    // )
                  ),
                  child: Text(''),
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              leading: const Icon(
                Icons.dashboard_outlined,
                color: Colors.black,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              leading: const Icon(
                Icons.dashboard_outlined,
                color: Colors.black,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 3'),
              leading: const Icon(
                Icons.dashboard_outlined,
                color: Colors.black,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 4'),
              leading: const Icon(
                Icons.dashboard_outlined,
                color: Colors.black,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.5,
            // ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: const Text('Exit App'),
              onTap: () {
                Future.delayed(const Duration(milliseconds: 500), () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(
                Icons.edit_location_alt_outlined,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: location()))
              },
            ),
          )
        ],
        //flexibleSpace: Container(color: Colors.white60 , height:26),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.dashboard,
              size: 22,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        elevation: 16,
        title: const Text(
          'A walk',
          textAlign: TextAlign.left,
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white60,
        selectedFontSize: 16,
      ),
    );
  }
}
