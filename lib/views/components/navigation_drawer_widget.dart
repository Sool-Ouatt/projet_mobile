import 'package:flutter/material.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/utilisateur.dart';
import 'package:samadeukuway/views/pages/logementAjout.dart';
import 'package:samadeukuway/views/pages/login.dart';
import 'package:samadeukuway/views/pages/registration.dart';

class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  bool _etatUser = false;
  String name = 'User';
  String email = 'User@gmail.com';

  @override
  Widget build(BuildContext context) {
    final urlImage =
        'http://stark-fortress-31703.herokuapp.com/uploads/no_Avatar_11538d5f94.png';
    _statusUser();
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            if (_etatUser)
              buildHeader(urlImage: urlImage, name: name, email: email),
            Container(
              padding: padding,
              child: Column(
                children: _etatUser
                    ? [
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Deconnexion',
                          icon: Icons.logout,
                          onClicked: () => selectedItem(context, 2),
                        ),
                        const SizedBox(height: 24),
                        Divider(color: Colors.white70),
                        const SizedBox(height: 24),
                        buildMenuItem(
                          text: 'Publier un appartement',
                          icon: Icons.add_business,
                          onClicked: () => selectedItem(context, 3),
                        ),
                      ]
                    : [
                        const SizedBox(height: 24),
                        buildMenuItem(
                          text: 'Créer Compte',
                          icon: Icons.account_box_outlined,
                          onClicked: () => selectedItem(context, 0),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Connexion',
                          icon: Icons.login,
                          onClicked: () => selectedItem(context, 1),
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    // required VoidCallback onClicked,
  }) =>
      InkWell(
        // onTap: onClicked,
        child: Container(
          color: Colors.blueAccent,
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              /*
              Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )*/
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Registration(title: "Création de compte"),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Login(),
        ));
        break;
      case 2:
        _deconnect();
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LogementAjout(),
        ));
        break;
    }
  }

  void _statusUser() async {
    Service service = Service();
    Utilisateur? courant = await service.getUserCourant();
    if (courant != null) {
      setState(() {
        _etatUser = true;
        name = courant.username;
        email = courant.email;
      });
    }
  }

  void _deconnect() async {
    Service service = Service();
    var dis = await service.deconnexion();
    if (dis) {
      setState(() {
        _etatUser = false;
        print("deconnecter");
      });
    }
  }
}
