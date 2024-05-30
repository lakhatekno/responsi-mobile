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
    return Card(
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Image.network(
                  data.displayIcon.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 24,),
              Text(
                data.displayName.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32
                ),
              ),
              SizedBox(height: 12,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                        data.description.toString()
                    ),
                  ],
                ),
              )
            ],
          )
        )
    );
  }
}
