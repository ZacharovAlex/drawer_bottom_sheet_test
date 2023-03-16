import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

          //  primarySwatch: Colors.blue,
          ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const TabBarView(children: [
        Text('HI!'),
      ],),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
                child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.blue,
            )),
            const ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.add_card_outlined),
              trailing: Icon(Icons.add_card_outlined),
            ),
            const ListTile(
              title: Text('Images'),
              leading: Icon(Icons.add_card_outlined),
              trailing: Icon(Icons.add_card_outlined),
            ),
            const ListTile(
              title: Text('Files'),
              leading: Icon(Icons.add_card_outlined),
              trailing: Icon(Icons.add_card_outlined),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54, foregroundColor: Colors.black),
                      child: const Text('Выход')),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54, foregroundColor: Colors.black),
                      child: const Text('Регистрация')),
                ],
              ),
            )
          ],
        ),
      ),
      endDrawer: Drawer(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 30,
            ),
            SizedBox(
              height: 8,
            ),
            Text('Текст')
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    bottomNavigationBar: BottomNavigationBar(items:const [
     BottomNavigationBarItem(
         label: 'f',
         icon: Icon(Icons.ice_skating)),
     BottomNavigationBarItem(
         label: 'f',
         icon: Icon(Icons.ice_skating)),
     BottomNavigationBarItem(
         label: 'f',
         icon: Icon(Icons.ice_skating)),
    ]),
    );
  }
}
