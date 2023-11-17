import 'package:flutter/materail.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.red,
        width: 200,
        child: Column(
          children: [
            DrawerHeader(
                child: Text(
              'M E N U',
              style: TextStyle(fontSize: 20, fontFamily: 'Freedom',),
            )),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('H O M E'),
              onTap: () {},
            )
          ],
        ),
      ), 
    );
  }
}
