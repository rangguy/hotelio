import 'package:course_hotelio/config/app_asset.dart';
import 'package:course_hotelio/config/app_color.dart';
import 'package:course_hotelio/config/app_format.dart';
import 'package:course_hotelio/controller/c_user.dart';
import 'package:course_hotelio/model/booking.dart';
import 'package:course_hotelio/model/hotel.dart';
import 'package:course_hotelio/source/booking_source.dart';
import 'package:course_hotelio/widget/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    Hotel hotel = ModalRoute.of(context)!.settings.arguments as Hotel;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(hotel, context),
          const SizedBox(height: 16),
          roomDetails(context),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                paymentMethod(context),
                const SizedBox(height: 20),
                ButtonCustom(
                  label: 'Process To Payment',
                  isExpanded: true,
                  onTap: () {
                    BookingSource.addBooking(
                      cUser.data.id!,
                      Booking(
                        id: '',
                        idHotel: hotel.id,
                        cover: hotel.cover,
                        name: hotel.name,
                        location: hotel.location,
                        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        guest: 1,
                        breakfast: 'Included',
                        checkInTime: '12:00 WIB',
                        night: 2,
                        serviceFee: 60000,
                        activities: 42000,
                        totalPayment: hotel.price + 2 + 60000 + 42000,
                        status: "PAID",
                        isDone: false,
                      ),
                    );
                    
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container paymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[100]!)),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(
            AppAsset.iconMasterCard,
            width: 50,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hotelio',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Balance ${AppFormat.currency(5000000)}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: AppColor.secondary),
        ],
      ),
    );
  }

  Container roomDetails(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Details',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          itemRoomDetails(context, 'date',
              AppFormat.date(DateTime.now().toIso8601String())),
          const SizedBox(height: 16),
          itemRoomDetails(context, 'Guest', '2 Guest'),
          const SizedBox(height: 16),
          itemRoomDetails(context, 'Breakfast', 'Included'),
          const SizedBox(height: 16),
          itemRoomDetails(context, 'Check-in Time', '14:00 WIB'),
          const SizedBox(height: 16),
          itemRoomDetails(context, '1 night', AppFormat.currency(1290000)),
          const SizedBox(height: 16),
          itemRoomDetails(context, 'Service fee', AppFormat.currency(50)),
          const SizedBox(height: 16),
          itemRoomDetails(context, 'Activities', AppFormat.currency(350)),
          const SizedBox(height: 16),
          itemRoomDetails(context, 'Total Payment', AppFormat.currency(13550)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Row itemRoomDetails(BuildContext context, String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Container header(Hotel hotel, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              hotel.cover,
              fit: BoxFit.cover,
              height: 70,
              width: 90,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  hotel.location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
