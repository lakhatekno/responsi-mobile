import 'package:flutter/material.dart';
import 'package:responsi_mobile/data/valoData.dart';
import 'package:responsi_mobile/model/agentDetailModel.dart';

class DetailAgentsPage extends StatefulWidget {
  final String id;
  const DetailAgentsPage({
    super.key,
    required this.id,
  });
  @override
  State<DetailAgentsPage> createState() => _DetailAgentsPageState();
}

class _DetailAgentsPageState extends State<DetailAgentsPage> {
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
            color: Color(0xFF2B3499),
          ),
        ),
        title: const Text(
          "Agent Info",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B3499)
          ),
        ),
      ),
      backgroundColor: Color(0xFF2B3499),
      body: FutureBuilder(
        future: ValoData.instance.loadDetailAgent(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            AgentDetailModel agent = AgentDetailModel.fromJson(snapshot.data!);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: _buildAgentDetail(agent),
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

  Widget _buildAgentDetail(AgentDetailModel results) {
    return _buildDetailAgentPage(results.data!);
  }

  Widget _buildDetailAgentPage(Data data) {
    List<Abilities>? abilities = data.abilities;
    return Card(
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(
                  children: [
                    Image.network(
                      data.background.toString(),
                      fit: BoxFit.fitHeight,
                    ),
                    Image.network(
                      data.fullPortrait.toString(),
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                )
              ),
              SizedBox(height: 24,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      data.displayName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 12,),
                    Text(
                        data.description.toString()
                    ),
                    _buildAbilities(abilities),
                  ],
                ),
              )
            ],
          )
        )
    );
  }

  Widget _buildAbilities(List<Abilities>? abilities) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: abilities!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildAbilityItems(abilities[index]);
      },
    );
  }

  Widget _buildAbilityItems(Abilities abilities) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Text(
                abilities.displayName.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
