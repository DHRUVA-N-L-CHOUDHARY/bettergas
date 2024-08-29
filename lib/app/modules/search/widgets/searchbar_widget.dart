import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {this.textEditingController,
      super.key,
      this.isSearch = true,
      this.onChanged});

  final TextEditingController? textEditingController;
  final Function(String value)? onChanged;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.grey.shade200),
      child: TextFormField(
        controller: textEditingController,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Enter your City or State',
          // prefixIcon: const Icon(Icons.location_on_outlined),
          prefixIcon: IconButton(
            onPressed: () {
              // if (isSearch) {
              //   textEditingController?.clear();
              //  clear != null ? clear!() : "";
              // }
            },
            icon: Icon(
              // isSearch ? Icons.close :
              Icons.search,
              color: kPrimaryBlue,
              size: 20.sp,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
        ),
      ),
    );
  }
}
