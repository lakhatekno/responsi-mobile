import 'package:responsi_mobile/data/baseNetwork.dart';

class ValoData {
  static ValoData instance = ValoData();
  Future<Map<String, dynamic>> loadAgentsList() {
    return ValoBaseNetwork.get("v1/agents/");
  }

  Future<Map<String, dynamic>> loadDetailAgent(id) {
    return ValoBaseNetwork.get("v1/agents/$id");
  }

  Future<Map<String, dynamic>> loadMaps() {
    return ValoBaseNetwork.get("v1/maps");
  }
}