import 'package:flutter/material.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/models/logement.dart';

class ListLogement extends StatefulWidget {
  const ListLogement({Key? key}) : super(key: key);

  @override
  _ListLogementState createState() => _ListLogementState();
}

class _ListLogementState extends State<ListLogement> {
  late Future<List<Logement>> futureRVs;
  Service service = Service();
  @override
  void initState() {
    super.initState();
    futureRVs = service.getLogements();
  }

  @override
  Widget build(BuildContext context) {
    futureRVs = service.getLogements();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Liste des logements"),
        ),
        body: Center(
          child: FutureBuilder<List<Logement>>(
            future: futureRVs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => ListTile(
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
                                  service
                                      .deleteLogement(snapshot.data![index].id);
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
                  ),
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
          ),
        )
        );
  }
}
