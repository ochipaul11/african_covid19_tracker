import 'package:african_covid19_tracker/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetCountriesData extends StatefulWidget {
  const GetCountriesData({Key? key}) : super(key: key);

  @override
  _GetCountriesDataState createState() => _GetCountriesDataState();
}

class _GetCountriesDataState extends State<GetCountriesData> {
  var uri = Uri.parse(
      "https://corona.lmao.ninja/v2/countries/DZ,AO,BJ,BW,BF,BI,CM,CV,CF,KM,CD,DJ,EG,GQ,ER,ET,GA,GM,GH,GN,GW,CI,KE,LS,LR,LY,MG,MW,ML,MR,MU,MA,MZ,NA,NE,NG,CG,RE,RW,SH,ST,SN,SC,SL,SO,ZA,SS,SD,SZ,TZ,TG,TN,UG,EH,ZM,ZW");
  late List<Country> countriesData;

  fetchData() async {
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final List<Country> countries = countryFromJson(res.body);
      countriesData = countries;
      return countries;
    }
    throw Exception("No response from server!");
  }

  @override
  Widget build(BuildContext context) {
    final _items = [
      "JANUARY",
      "FEBRUARY",
      "MARCH",
      "JANUARY",
      "FEBRUARY",
      "MARCH",
      "JANUARY",
      "FEBRUARY",
      "MARCH",
      "JANUARY",
      "FEBRUARY",
      "MARCH",
      "JANUARY",
      "FEBRUARY",
      "MARCH",
      "JANUARY",
      "FEBRUARY",
      "MARCH"
    ];
    //List<String>.generate(10000, (i) => 'Item $i');
    return Scaffold(
        appBar: AppBar(title: Text("COVID19 Africa Tracker")),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: const <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text('Paul Okeyo'),
                  accountEmail: Text('paulokeyo@hotmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1492681290082-e932832941e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80'),
                  )),
              ListTile(
                title: Text("Email"),
                subtitle: Text("Paulokeyo@htmail.com"),
                trailing: Icon(Icons.edit),
                // onTap: _changeName,
              ),
              ListTile(
                title: Text("Paul Okeyo"),
                subtitle: Text('Developer'),
                trailing: Icon(Icons.edit),
                // onTap: _changeName,
              )
            ],
          ),
        ),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text("No active connection"));
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Some Error Occured"),
                  );
                }
                return ListView.builder(
                  itemCount: countriesData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Card(
                        child: Row(
                          children: [
                            CircleAvatar(
                                backgroundImage: NetworkImage(
                                    countriesData[index].countryInfo.flag)),
                            Column(
                              children: [
                                Text(
                                  countriesData[index].country,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text("Infected: ${countriesData[index].cases}",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.left),
                                Text(
                                    "Recovered: ${countriesData[index].recovered}",
                                    style: TextStyle(color: Colors.grey))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ));
  }
}
