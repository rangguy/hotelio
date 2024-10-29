import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hotelio/model/booking.dart';

class BookingSource {
  static Future<Booking?> checkIsBooked(String userId, String hotelId) async {
    var result = await FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('Booking')
        .where('id_hotel', isEqualTo: hotelId)
        .where('is_done', isEqualTo: false)
        .get();
    if (result.size > 0) {
      return Booking.fromJson(result.docs.first.data());
    }
    return null;
  }
}
