import 'package:flutter/material.dart';

class MyAppDrawer extends StatelessWidget {
  MyAppDrawer({
    Key key,
    this.onTap1,
    this.onTap2,
    this.onTap3,
  }) : super(key: key);
  Function onTap1;
  Function onTap2;
  Function onTap3;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text('moh.khalifa04@gmail.com'),
            accountName: Text('Mohammed Khalifa'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/prof.jpg'),
            ),
          ),
          ListTile(
            title: Text('All Tasks'),
            subtitle: Text('All tasks that I have'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: onTap1,
          ),
          ListTile(
            title: Text('Complete Tasks'),
            subtitle: Text('Task that I do'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: onTap2,
          ),
          ListTile(
            title: Text('Complete Tasks'),
            subtitle: Text('Tasks that still must to do'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: onTap3,
          ),
          Spacer(),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
