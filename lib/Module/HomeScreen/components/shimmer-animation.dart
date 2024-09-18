import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:userapp/Module/HomeScreen/components/first_card.dart';
import 'package:userapp/utils/Constants/constants.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: 400.w,
                height: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.grey,
                ),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: FirstCard(),
            ),
            16.h.ph,
            Center(
              child: Container(
                width: 100.w,
                height: 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey,
                ),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Container(
                height: 47.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.r),
                    color: Colors.grey),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: 100.w,
                height: 10.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.r)),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 145.63.w,
                    height: 117.w,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                  28.w.pw,
                  SizedBox(
                    width: 145.63.w,
                    height: 117.w,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ],
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: 100.w,
                height: 10.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.r)),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 145.63.w,
                    height: 117.w,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                  28.w.pw,
                  SizedBox(
                    width: 145.63.w,
                    height: 117.w,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
