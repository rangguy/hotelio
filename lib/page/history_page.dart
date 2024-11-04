import 'package:course_hotelio/config/app_asset.dart';
import 'package:course_hotelio/config/app_format.dart';
import 'package:course_hotelio/controller/c_history.dart';
import 'package:course_hotelio/controller/c_user.dart';
import 'package:course_hotelio/model/booking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cHistory = Get.put(CHistory());
  final cUser = Get.put(CUser());

  @override
  void initState() {
    cHistory.getListBooking(cUser.data.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24),
        header(context),
        const SizedBox(height: 24),
        GetBuilder<CHistory>(builder: (_) {
          return GroupedListView<Booking, String>(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            elements: _.listBooking,
            groupBy: (element) => element.date,
            groupSeparatorBuilder: (String groupByValue) {
              String date = DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                      groupByValue
                  ? 'Today New'
                  : AppFormat.dateMonth(groupByValue);
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  date,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            },
            itemBuilder: (context, dynamic element) => Text(element['name']),
            itemComparator: (item1, item2) =>
                item1['name'].compareTo(item2['name']),
            useStickyGroupSeparators: true,
            floatingHeader: true,
            order: GroupedListOrder.ASC, // optional
            footer: Text("Widget at the bottom of list"),
          );
        }),
      ],
    );
  }

  Padding header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              AppAsset.profile,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'My Booking',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const Text(
                '100 transactions',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
