import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  Widget draweritems({required Icon icondata, required String text}) {
    return ListTile(
      leading: icondata,
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
              child: Image(
            image: AssetImage('assets/images/drawer.png'),
            fit: BoxFit.cover,
          )),
          const Divider(
            color: Colors.black38,
          ),
          draweritems(
            icondata: const Icon(
              FontAwesomeIcons.fire,
              color: Colors.deepOrangeAccent,
            ),
            text: 'Top',
          ),
          draweritems(
            icondata: const Icon(
              FontAwesomeIcons.hackerNews,
              color: Colors.deepOrangeAccent,
            ),
            text: 'New',
          ),
          draweritems(
            icondata: const Icon(
              FontAwesomeIcons.question,
              color: Colors.deepOrangeAccent,
            ),
            text: 'Ask HN',
          ),
          draweritems(
            icondata: const Icon(
              FontAwesomeIcons.tv,
              color: Colors.deepOrangeAccent,
            ),
            text: 'Show HN',
          ),
          draweritems(
            icondata: const Icon(
              FontAwesomeIcons.bookmark,
              color: Colors.deepOrangeAccent,
            ),
            text: 'Bookmark',
          ),
          const Divider(
            color: Colors.black,
          ),
          draweritems(
            icondata: const Icon(
              Icons.settings,
              color: Colors.deepOrangeAccent,
            ),
            text: 'Settings',
          ),
          draweritems(
            icondata: const Icon(
              Icons.new_releases,
              color: Colors.deepOrangeAccent,
            ),
            text: 'New Version',
          ),
        ],
      ),
    );
  }
}
