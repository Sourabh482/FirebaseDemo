import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../global/fireabse_services/firebase_analytics.dart';
import '../../../global/fireabse_services/firebase_dynamic_links.dart';
import '../../../routes/app_pages.dart';
import '../controller/screen_one_controller.dart';

class ScreenOne extends GetView<ScreenOneController> {
  ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen One"),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getAppBar(),
              getButton(),
              ElevatedButton(
                  onPressed: () {
                    FirebaseDynamic().createDynamicLink(true);
                  },
                  child: Text("Generate Dynamic link"))
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBar() {
    return Container(
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 0.0)],
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: InkWell(
                    onTap: () {
                      FirebaseCrashlytics.instance.crash();
                    },
                    child: Text("TEST CRASH")),
              ),
              Spacer(),
              Container(
                child: InkWell(
                    onTap: () {
                      _sendAnalyticsEvent();
                    },
                    child: Text("Analytics Test")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getButton() {
    return Container(
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 0.0)],
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.screen_two);
                    },
                    child: Text("Second Screen")),
              ),
              Spacer(),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.screen_three);
                    },
                    child: Text("Screen Three")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendAnalyticsEvent() async {
    await FirebaseAnal.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
        'items': [itemCreator()]
      },
    );
  }

  AnalyticsEventItem itemCreator() {
    return AnalyticsEventItem(
      affiliation: 'affil',
      coupon: 'coup',
      creativeName: 'creativeName',
      creativeSlot: 'creativeSlot',
      discount: 2.22,
      index: 3,
      itemBrand: 'itemBrand',
      itemCategory: 'itemCategory',
      itemCategory2: 'itemCategory2',
      itemCategory3: 'itemCategory3',
      itemCategory4: 'itemCategory4',
      itemCategory5: 'itemCategory5',
      itemId: 'itemId',
      itemListId: 'itemListId',
      itemListName: 'itemListName',
      itemName: 'itemName',
      itemVariant: 'itemVariant',
      locationId: 'locationId',
      price: 9.99,
      currency: 'USD',
      promotionId: 'promotionId',
      promotionName: 'promotionName',
      quantity: 1,
    );
  }
}
