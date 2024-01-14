import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecode_fess/presentation/core/color_values.dart';
import 'package:ecode_fess/presentation/core/shared_data.dart';
import 'package:ecode_fess/presentation/core/ui_constants.dart';
import 'package:ecode_fess/presentation/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final bool isHome;
  final VoidCallback? onSearchTap;

  const CustomAppBar({super.key, required this.title, this.isHome = false, this.onSearchTap});

  @override
  State<CustomAppBar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: UiConstants.xsPadding, horizontal: UiConstants.lgPadding),
      decoration: const BoxDecoration(
        color: ColorValues.white,
        boxShadow: UiConstants.defaultShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (!widget.isHome) AutoRouter.of(context).pop();
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UiConstants.mdRadius),
                color: widget.isHome ? ColorValues.surface : Colors.transparent,
              ),
              child: Center(
                child: widget.isHome
                  ? Image.asset(
                    'assets/images/ic_app.png',
                    width: 28,
                    height: 28,
                  )
                  : const Icon(
                    Iconsax.arrow_left,
                    size: 24,
                  ),
              ),
            ),
          ),
          const SizedBox(width: UiConstants.xxsSpacing),
          Expanded(
            child: CustomTitle(
              title: widget.title,
              isLarge: widget.isHome,
              textAlign: widget.isHome ? TextAlign.left : TextAlign.center,
            ),
          ),
          const SizedBox(width: UiConstants.xxsSpacing),
          if (widget.isHome) GestureDetector(
            onTap: widget.onSearchTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UiConstants.mdRadius),
                border: Border.all(
                  color: ColorValues.grey10,
                  width: 0.5,
                ),
                color:  ColorValues.surface,
              ),
              child: const Icon(
                Iconsax.search_normal_1,
                size: 24,
              ),
            ),
          ),
          if (widget.isHome) const SizedBox(width: UiConstants.xsSpacing),
          GestureDetector(
            onTap: () {},
            child: ValueListenableBuilder(
              valueListenable: SharedData.userData,
              builder: (_, __, ___) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(UiConstants.mdRadius),
                    border: Border.all(
                      color: ColorValues.grey10,
                      width: 0.5,
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(SharedData.userData.value?.image ?? SharedData.defaultAvatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      )
    );
  }
}
