import 'package:african_covid19_tracker/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var uri = Uri.parse("https://corona.lmao.ninja/v2/countries/DZ,AO,BJ,BW,BF,BI,CM,CV,CF,KM,CD,DJ,EG,GQ,ER,ET,GA,GM,GH,GN,GW,CI,KE,LS,LR,LY,MG,MW,ML,MR,MU,MA,MZ,NA,NE,NG,CG,RE,RW,SH,ST,SN,SC,SL,SO,ZA,SS,SD,SZ,TZ,TG,TN,UG,EH,ZM,ZW");
  late List<Country> countriesData;
  fetchData() async{
    final res = await http.get(uri);

    if (res.statusCode == 200){
      final List<Country> countries = countryFromJson(res.body);
      countriesData = countries;
      print(countries.last.country);
      return countries;
    }
    throw Exception("No response from server!");
  }
  @override
  Widget build(BuildContext context) {
    final _items =["JANUARY", "FEBRUARY","MARCH","JANUARY", "FEBRUARY","MARCH","JANUARY", "FEBRUARY","MARCH","JANUARY", "FEBRUARY","MARCH","JANUARY", "FEBRUARY","MARCH","JANUARY", "FEBRUARY","MARCH"];
    //List<String>.generate(10000, (i) => 'Item $i');
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID19 Africa Tracker")),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context,snapshot){
            switch (snapshot.connectionState){

              case ConnectionState.none:
                return Center(
                  child: Text("No active connection")
                );
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError){
                  return Center(
                    child: Text("Some Error Occured"),
                  );
                }
              return ListView.builder(
                itemCount: countriesData.length,
                itemBuilder: (context,index){
                  return Container(
                    child: Card(
                      child: Row(
                        children: [
                          CircleAvatar(backgroundImage: NetworkImage(countriesData[index].countryInfo.flag)),
                          Column(
                            children: [
                              Text(countriesData[index].country,
                                style:
                                TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                              Text("Infected: ${countriesData[index].cases}", style:
                              TextStyle(color: Colors.grey),textAlign: TextAlign.left),
                              Text("Recovered: ${countriesData[index].recovered}", style:
                              TextStyle(color: Colors.grey))
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
        )
    );
  }
}
