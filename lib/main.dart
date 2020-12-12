import 'package:flutter/material.dart';
import 'package:to_do_geeks/models/tasks_model.dart';
import 'package:to_do_geeks/utilties/my_app_drawer.dart';

import 'dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
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
  String title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  myFun(int index) {
    _tabController.animateTo(index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyAppDrawer(
        onTap1: () {
          myFun(0);
        },
        onTap2: () {
          myFun(1);
        },
        onTap3: () {
          myFun(2);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            title = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2),
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.teal,
                          onPressed: () {
                            allTasks
                                .add(Tasks(title: title, isAccepted: false));
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: Center(
                            child: Text('Add Task'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      appBar: AppBar(
        title: Text('To Do List'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.purpleAccent,
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
                    leading: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        allTasks.remove(e);
                        showSnackBar('${e.title} Deleted');
                        setState(() {});
                      },
                    ),
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
          SingleChildScrollView(
            child: Column(
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

  showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: "Close",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
