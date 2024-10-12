import 'package:course_hotelio/config/app_asset.dart';
import 'package:course_hotelio/config/app_color.dart';
import 'package:course_hotelio/controller/c_nearby.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NearbyPage extends StatelessWidget {
  NearbyPage({super.key});
  final cNearby = Get.put(CNearby());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 24,
        ),
        header(context),
        const SizedBox(
          height: 20,
        ),
        searchField(),
        const SizedBox(
          height: 30,
        ),
        categories(),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  GetBuilder<CNearby> categories() {
    return GetBuilder<CNearby>(builder: (_) {
      return SizedBox(
        height: 45,
        child: ListView.builder(
          itemCount: _.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String category = _.categories[index];
            return Padding(
              padding: EdgeInsets.fromLTRB(
                index == 0 ? 16 : 8,
                0,
                index == cNearby.categories.length - 1 ? 16 : 8,
                0,
              ),
              child: Material(
                color: category == _.category ? AppColor.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    cNearby.category = category;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Container searchField() {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search by name or city',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(45),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(45),
                child: const SizedBox(
                  height: 45,
                  width: 45,
                  child: Center(
                    child: ImageIcon(
                      AssetImage(AppAsset.iconSearch),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
                'Near Me',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const Text(
                '100 Hotels',
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
