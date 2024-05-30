import 'package:flutter/material.dart';
import 'package:responsi_mobile/data/valoData.dart';
import 'package:responsi_mobile/model/agentsModel.dart';
import 'package:responsi_mobile/view/detailAgentsPage.dart';

class AgentPage extends StatefulWidget {
  const AgentPage({super.key});

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
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
          "Agents Name",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B3499)
          ),
        ),
      ),
      backgroundColor: Color(0xFF2B3499),
      body: FutureBuilder(
        future: ValoData.instance.loadAgentsList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            AgentsModel agentsList = AgentsModel.fromJson(snapshot.data!);
            return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: _buildAgentsList(agentsList),
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

  Widget _buildAgentsList(AgentsModel results) {
    return ListView.builder(
      itemCount: results.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemAgents(results.data![index]);
      },
    );
  }

  Widget _buildItemAgents(Data data) {
    return InkWell(
      onTap: () {

        Navigator.push(
          context,
            MaterialPageRoute(builder: (context) {
              return DetailAgentsPage(id: data.uuid.toString());
            })
        );
      },
      child: Card(
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
      )
    );
  }
}
