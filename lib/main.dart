import 'package:flutter/material.dart';

import 'dummy_data.dart';

void main() {
  runApp(MyApp());
}

var themeData = ThemeData.light();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      home: MyList(),
    );
  }
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> with SingleTickerProviderStateMixin {
  var _tabController;
  var icon = Icons.brightness_2_rounded;
  var color = Colors.black;
  bool isDark = false;
  void changeTheme() {
    if (!isDark) {
      icon = Icons.wb_sunny;
      color = Colors.yellow;
      themeData = ThemeData.dark();
      isDark = true;
    } else {
      icon = Icons.brightness_2_rounded;
      color = Colors.black;
      themeData = ThemeData.light();
      isDark = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        actions: [
          IconButton(
            icon: Icon(
              icon,
              color: color,
            ),
            onPressed: () {
              setState(() {
                changeTheme();
              });
            },
          )
        ],
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'All Tasks',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Done',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Waiting',
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: allTasks
                .map(
                  (e) => ListTile(
                    title: Text(e.title),
                    trailing: Checkbox(
                      value: e.isAccepted,
                      onChanged: (value) {
                        e.isAccepted = value;
                        setState(() {});
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          Column(
            children: allTasks
                .where(
                  (element) => element.isAccepted == true,
                )
                .map(
                  (e) => ListTile(
                    title: Text(e.title),
                    trailing: Checkbox(
                      value: e.isAccepted,
                      onChanged: (value) {
                        e.isAccepted = value;
                        setState(() {});
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          Column(
            children: allTasks
                .where(
                  (element) => element.isAccepted == false,
                )
                .map(
                  (e) => ListTile(
                    title: Text(e.title),
                    trailing: Checkbox(
                      value: e.isAccepted,
                      onChanged: (value) {
                        e.isAccepted = value;
                        setState(() {});
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
