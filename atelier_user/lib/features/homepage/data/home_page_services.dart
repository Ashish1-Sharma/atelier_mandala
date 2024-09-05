import '../../../global/global_firebase.dart';

class HomePageServices {
  static Future<List<dynamic>> fetchData() async {
    // Create a list to store the results of each Future
    List<dynamic> results = [];

    try {
      // Fetch data from each collection
      final workshopsFuture = GlobalFirebase.cloud.collection('workshops')
          .limit(1)
          .where('isPublic', isEqualTo: true)
          .get();

      final takeawayFuture = GlobalFirebase.cloud.collection('takeaway')
          .limit(1)
          .where('isPublic', isEqualTo: true)
          .get();

      final storeFuture = GlobalFirebase.cloud.collection('store')
          .limit(1)
          .where('isPublic', isEqualTo: true)
          .get();

      // Wait for all futures to complete
      final workshopSnapshot = await workshopsFuture;
      if (workshopSnapshot.docs.isNotEmpty) {
        results.add(workshopSnapshot.docs.first); // Assuming only 1 workshop
      }

      final takeawaySnapshot = await takeawayFuture;
      if (takeawaySnapshot.docs.isNotEmpty) {
        results.add(takeawaySnapshot.docs.first);
      }

      final storeSnapshot = await storeFuture;
      if (storeSnapshot.docs.isNotEmpty) {
        results.add(storeSnapshot.docs.first);
      }
    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
    }

    // Print results length for debugging
    print('Results length: ${results.length}');
    return results;
  }
}
