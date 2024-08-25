import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payuung_pribadi/cubit/bottom_sheet_cubit.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final String label;
  final int pageIndex;
  final Function()? onPressed;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.pageIndex,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<BottomSheetCubit, BottomSheetState>(
                builder: (context, state) {
              int activePageIndex = 0;
              if (state is BottomSheetPageState) {
                activePageIndex = state.pageIndex;
              }
              return SvgPicture.asset(
                icon,
                height: 32,
                width: 32,
                color:
                    pageIndex == activePageIndex ? Colors.yellow : Colors.black,
              );
            }),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
