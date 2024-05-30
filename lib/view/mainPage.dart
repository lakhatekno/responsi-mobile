import 'package:flutter/material.dart';
import 'package:responsi_mobile/view/agentsPage.dart';
import 'package:responsi_mobile/view/mapsPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2B3499),
          title: const Text(
            "Main Page",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const AgentPage();
                        })
                    );
                  },
                  child: const Text("Agents", style: TextStyle(color: Color(0xFF2B3499), fontWeight: FontWeight.w700),),
                ),
              ),
              SizedBox(height: 16,),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const MapsPage();
                        })
                    );
                  },
                  child: Text("Maps", style: TextStyle(color: Color(0xFF2B3499), fontWeight: FontWeight.w700),),
                ),
              ),
              const SizedBox(height: 32,),
              const Text(
                  "Muhammad Islakha - 123210096",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B3499)
                  )
              )
            ],
          ),
        )
      );
  }
}
