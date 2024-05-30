import 'package:flutter/material.dart';
import 'package:responsi_mobile/data/valoData.dart';
import 'package:responsi_mobile/model/mapsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Future<void> _launchedUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          )
      ),
      backgroundColor: Color(0xFF2B3499),
      body: FutureBuilder(
        future: ValoData.instance.loadMaps(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            MapsModel mapsList = MapsModel.fromJson(snapshot.data!);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: _buildMapsList(mapsList),
                ),
              )
            );
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Eror");
  }
  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildMapsList(MapsModel results) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: results.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemMaps(results.data![index]);
      },
    );
  }

  Widget _buildItemMaps(Data data) {
    return InkWell(
      onTap: () {_launchedUrl(data.displayIcon!);},
      child: Card(
          clipBehavior: Clip.hardEdge,
          child: Container(
            height: 400,
            child: Column(
              children: [
                Container(
                  width: 400,
                  child: Image.network(
                    data.splash.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  data.displayName.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2B3499),
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  data.coordinates.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
      ),
    );
  }
}
