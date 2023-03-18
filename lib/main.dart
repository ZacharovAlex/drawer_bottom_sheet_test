import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillbox_5/show_modal.dart';

import 'main_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('BUILD MAIN APP');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (_) => CounterCubit(), child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    print('BUILD MAIN PAGE!');
    return Scaffold(
      appBar: AppBar(
        actions: const [
          BuilderAppBar(),
        ],
        title: Text(title),
      ),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return ScreensBuilder(
            screenIndex: state,
          );
        },
      ),
      drawer: const LeftDrawer(),
      endDrawer: const RightDrawer(),
      floatingActionButton: const FloatingButton(),
      bottomNavigationBar: BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
              onTap: (index) => context.read<CounterCubit>().changeScreen(index),
              currentIndex: state,
              items: const [
                BottomNavigationBarItem(label: 'Photo', icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: 'Chat', icon: Icon(Icons.chat)),
                BottomNavigationBarItem(label: 'Albums', icon: Icon(Icons.album)),
              ]);
        },
      ),
    );
  }
}

class BuilderAppBar extends StatelessWidget {
  const BuilderAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('BUILD APPBAR');
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
    print('BUILD Floating buttton!');
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
    print('BUILD RIght Drawer!');
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
    print('BUILD LEFT DRAWER');
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
              child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.blue,
          )),
          const ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.photo_camera_front),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            title: Text('Images'),
            leading: Icon(Icons.image),
            trailing: Icon(Icons.arrow_forward_ios),
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
    print('BUILD Screen content!');
    return Center(
      child: Text(content),
    );
  }
}

class ScreensBuilder extends StatefulWidget {
  final int screenIndex;

  const ScreensBuilder({Key? key, required this.screenIndex}) : super(key: key);

  @override
  State<ScreensBuilder> createState() => _ScreensBuilderState();
}

class _ScreensBuilderState extends State<ScreensBuilder> with TickerProviderStateMixin {
  late TabController _tabController;

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
      context.read<CounterCubit>().changeScreen(_tabController.index);
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD Screen!');
    _tabController.index = widget.screenIndex;
    return TabBarView(
      controller: _tabController,
      physics: const BouncingScrollPhysics(),
      dragStartBehavior: DragStartBehavior.down,
      children: const [
        WidgetContent(content: 'Photo'),
        WidgetContent(content: 'Chat'),
        WidgetContent(content: 'Album'),
      ],
    );
  }
}
