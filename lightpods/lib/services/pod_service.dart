import '../logic/pod/pod_base.dart';

class PodService {
  final List<PodBase> _pods = [];

  List<PodBase> getPods() => _pods;

  int get numberOfConnectedPods =>
      _pods.where((element) => element.isConnected).length;

  void addPod(PodBase pod) {
    if (!_podInList(pod)) {
      _pods.add(pod);
    }
  }

  void removePod(PodBase pod) {
    _pods.removeWhere((element) => element.id == pod.id);
  }

  bool _podInList(PodBase pod) => _pods.any((element) => element.id == pod.id);

  PodBase getPod(String id) => _pods.firstWhere((element) => element.id == id);
}
