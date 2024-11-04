import 'package:course_hotelio/config/app_asset.dart';
import 'package:course_hotelio/config/app_color.dart';
import 'package:course_hotelio/config/app_format.dart';
import 'package:course_hotelio/model/booking.dart';
import 'package:flutter/material.dart';

class DetailBookingPage extends StatelessWidget {
  DetailBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Booking booking = ModalRoute.of(context)!.settings.arguments as Booking;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Detail Booking',
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
          header(booking, context),
          const SizedBox(height: 16),
          roomDetails(booking, context),
          const SizedBox(height: 16),
          paymentMethod(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

Container paymentMethod(BuildContext context) {
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
          'Payment Method',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!),
          ),
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
                      'Elliot York Owell',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Balance ${AppFormat.currency(80000)}',
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
        ),
      ],
    ),
  );
}

Container roomDetails(Booking booking, BuildContext context) {
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
        itemRoomDetails(
          context,
          'Date',
          AppFormat.date(booking.date),
        ),
        const SizedBox(height: 16),
        itemRoomDetails(context, 'Guest', '${booking.guest} Guest'),
        const SizedBox(height: 16),
        itemRoomDetails(context, 'Breakfast', booking.breakfast),
        const SizedBox(height: 16),
        itemRoomDetails(context, 'Check-in Time', booking.checkInTime),
        const SizedBox(height: 16),
        itemRoomDetails(
            context, '${booking.night} night', AppFormat.currency(1000000)),
        const SizedBox(height: 16),
        itemRoomDetails(
          context,
          'Service fee',
          AppFormat.currency(booking.serviceFee.toDouble()),
        ),
        const SizedBox(height: 16),
        itemRoomDetails(
          context,
          'Activities',
          AppFormat.currency(booking.activities.toDouble()),
        ),
        const SizedBox(height: 16),
        itemRoomDetails(
          context,
          'Total Payment',
          AppFormat.currency(booking.totalPayment.toDouble()),
        ),
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

Container header(Booking booking, BuildContext context) {
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
            booking.cover,
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
                booking.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                booking.location,
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
