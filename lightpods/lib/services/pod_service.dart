import '../logic/pod/pod_base.dart';

class PodService {
  late List<PodBase> _pods = [];

  List<PodBase> getPods() => _pods;

  void addPod(PodBase pod) {
    _pods.add(pod);
  }

  void removePod(PodBase pod) {
    _pods.removeWhere((element) => element.id == pod.id);
  }

  PodBase getPod(String id) => _pods.firstWhere((element) => element.id == id);
}
