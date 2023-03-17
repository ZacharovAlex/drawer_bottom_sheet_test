import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skillbox_5/show_modal.dart';

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
        primarySwatch: Colors.blue,
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _screenIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    _tabController.addListener(() {
      _screenIndex = _tabController.index;
      setState(() {});
    });
    super.didChangeDependencies();
  }

  void changeTab(int index) {
    _screenIndex = index;
    _tabController.index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          BuilderAppBar(),
        ],
        title: Text(widget.title),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children: const [
          WidgetContent(content: 'Photo'),
          WidgetContent(content: 'Chat'),
          WidgetContent(content: 'Album'),
          // for (String content in contentList) WidgetStack(content: content)
        ],
      ),
      drawer: const LeftDrawer(),
      endDrawer: const RightDrawer(),
      floatingActionButton: const FloatingButton(),
      bottomNavigationBar:
          BottomNavigationBar(onTap: (index) => changeTab(index), currentIndex: _screenIndex, items: const [
        BottomNavigationBarItem(label: 'Photo', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Chat', icon: Icon(Icons.chat)),
        BottomNavigationBarItem(label: 'Albums', icon: Icon(Icons.album)),
      ]),
    );
  }
}

class BuilderAppBar extends StatelessWidget {
  const BuilderAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.photo_camera_front_outlined),
        onPressed: () => Scaffold.of(context).openEndDrawer(),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showModal(context),
      child: const Icon(Icons.add),
    );
  }
}

class RightDrawer extends StatelessWidget {
  const RightDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                NetworkImage('https://toppng.com/uploads/preview/mr-bean-11530959016fkraybfdhu.png'),
          ),
          SizedBox(
            height: 8,
          ),
          Text('Bean')
        ],
      ),
    ));
  }
}

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.5), foregroundColor: Colors.black),
                    child: const Text('Выход')),
                TextButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.5), foregroundColor: Colors.black),
                    child: const Text('Регистрация')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WidgetContent extends StatelessWidget {
  final String content;

  const WidgetContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(content),
    );
  }
}
