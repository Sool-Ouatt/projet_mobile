import 'package:flutter/material.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/logement.dart';
import 'package:samadeukuway/views/components/logementCard.dart';

class BodyHome1 extends StatefulWidget {
  BodyHome1({Key? key}) : super(key: key);

  @override
  _BodyHome1State createState() => _BodyHome1State();
}

class _BodyHome1State extends State<BodyHome1> {
  late Future<List<Logement>> futureLogement;
  Service service = Service();
  @override
  void initState() {
    super.initState();
    futureLogement = service.getLogements();
  }

  @override
  Widget build(BuildContext context) {
    futureLogement = service.getLogements();

    return FutureBuilder<List<Logement>>(
      future: futureLogement,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            // reverse: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => LogementCard(
              logement: Logement(
                  snapshot.data![snapshot.data!.length - 1 - index].id,
                  snapshot.data![snapshot.data!.length - 1 - index].photo,
                  snapshot.data![snapshot.data!.length - 1 - index].description,
                  snapshot.data![snapshot.data!.length - 1 - index].ville,
                  snapshot.data![snapshot.data!.length - 1 - index].quartier,
                  snapshot
                      .data![snapshot.data!.length - 1 - index].prixLocation,
                  snapshot.data![snapshot.data!.length - 1 - index].comments,
                  snapshot
                      .data![snapshot.data!.length - 1 - index].proprietaire),
              gest: true,
            ),
            /*
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amberAccent,
                radius: 30,
                child: Text(snapshot.data![index].ville[0].toUpperCase()),
              ),
              title: Text(
                "${snapshot.data![index].ville},   ${snapshot.data![index].quartier}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(snapshot.data![index].description),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print(
                              "Vous voulez supprimer ${snapshot.data![index]}");
                          setState(() {
                            service.deleteRvs(snapshot.data![index].idLogement);
                          });
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.deepOrange,
                        )),
                  ),
                  const Spacer(),
                  Expanded(
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.deepOrange,
                        )),
                  )
                ],
              ),
            ),*/
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 10,
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
