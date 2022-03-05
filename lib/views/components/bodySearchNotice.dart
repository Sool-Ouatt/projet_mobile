import 'package:flutter/material.dart';
import 'package:samadeukuway/controllers/service.dart';
import 'package:samadeukuway/views/components/searchNoticeCard.dart';
import '../../models/searchNotice.dart';

class BodyNoticeSearch extends StatefulWidget {
  BodyNoticeSearch({Key? key}) : super(key: key);

  @override
  BodyNoticeSearchState createState() => BodyNoticeSearchState();
}

class BodyNoticeSearchState extends State<BodyNoticeSearch> {
  late Future<List<SearchNotice>> futureNoticeSearch;
  Service service = Service();

  @override
  void initState() {
    super.initState();
    futureNoticeSearch = service.getSearchNotices();
  }

  @override
  Widget build(BuildContext context) {
    futureNoticeSearch = service.getSearchNotices();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Les avis de recherche d'appartements"),
          centerTitle: true,
        ),
        body: Center(
          child: RefreshIndicator(
              child: FutureBuilder<List<SearchNotice>>(
                future: futureNoticeSearch,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => SearchNoticeCard(
                        avis: SearchNotice(
                            snapshot
                                .data![snapshot.data!.length - 1 - index].id,
                            snapshot
                                .data![snapshot.data!.length - 1 - index].ville,
                            snapshot.data![snapshot.data!.length - 1 - index]
                                .quartier,
                            snapshot.data![snapshot.data!.length - 1 - index]
                                .description,
                            snapshot.data![snapshot.data!.length - 1 - index]
                                .demandeur,
                            snapshot.data![snapshot.data!.length - 1 - index]
                                .comments),
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
              onRefresh: _onRefresh),
        ));
  }

  Future<void> _onRefresh() {
    setState(() {
      futureNoticeSearch = service.getSearchNotices();
    });
    return Future.delayed(Duration(seconds: 5));
  }
}

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
                                  /*service
                                      .deleteLogement(snapshot.data![index].id);*/
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
*/