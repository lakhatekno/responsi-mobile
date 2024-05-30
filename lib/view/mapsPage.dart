import 'package:flutter/material.dart';
import 'package:responsi_mobile/data/valoData.dart';
import 'package:responsi_mobile/model/mapsModel.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
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
              ),
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
    return ListView.builder(
      itemCount: results.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemMaps(results.data![index]);
      },
    );
  }

  Widget _buildItemMaps(Data data) {
    return Card(
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 100,
          child: Row(
            children: [
              Container(
                width: 100,
                child: Image.network(
                  data.displayIcon.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 25),
              Text(data.displayName.toString()),
            ],
          ),
        )
    );
  }
}
