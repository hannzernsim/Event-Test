import 'package:flutter/material.dart';
import 'package:event_app/constants/dimens_constants.dart';
import 'package:shimmer/shimmer.dart';

class PrimaryShimmer extends StatelessWidget {
  final bool showShimmer, wrapWithBackground;
  final Widget child;

  const PrimaryShimmer({
    Key? key,
    required this.child,
    this.showShimmer = false,
    this.wrapWithBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showShimmer) {
      return AbsorbPointer(
        child: Container(
          padding: const EdgeInsets.only(top: xSmallSpace),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade50,
            period: Duration(milliseconds: 900),
            child: wrapWithBackground
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(midRadius),
                      color: Colors.white,
                    ),
                    child: child,
                  )
                : child,
          ),
        ),
      );
    }

    return child;
  }
}
