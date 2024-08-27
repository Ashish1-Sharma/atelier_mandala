import '../../../../global_firebase.dart';

class DashboardData {
  static Stream<int> streamCounters(int idx) {
    switch (idx) {
      case 0:
        return userCountStream();
      case 1:
        return enrolledCountStream();
      case 2:
        return tOrderCountStream();
      case 3:
        return paymentsCountStream();
      case 4:
        return sOrderCountStream();
      default:
        throw Exception('Invalid thing for stream');
    }
  }

  static Stream<int> userCountStream() {
    return GlobalFirebase.cloud
        .collection("Users")
        .snapshots()
        .map((snapshot) => snapshot.size);
  }
  static Stream<int> enrolledCountStream() {
    return GlobalFirebase.cloud
        .collection("enrolled")
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  static Stream<int> tOrderCountStream() {
    return GlobalFirebase.cloud
        .collection("takeaway")
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  static Stream<int> paymentsCountStream() {
    return GlobalFirebase.cloud
        .collection("payments")
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  static Stream<int> sOrderCountStream() {
    return GlobalFirebase.cloud
        .collection("store")
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  static void newUsers() async {
     GlobalFirebase.cloud.collection("Users").snapshots().take(5).toList().then((value) {

     },);
  }
}
