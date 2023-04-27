import 'package:flutter/material.dart';
import '../../Core/AppColors/app_colors.dart';

import 'Widgets/CustomButton/custom_button.dart';
import 'Widgets/Custom_Text/custom_text.dart';

class ProductsDetails extends StatelessWidget {
  const ProductsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'المنتجات',
            fontSize: 30,
            color: AppColors.white,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 3.3,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 4,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/rice.jpg',
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                      const SizedBox(height: 5),
                      const CustomText('20\$'),
                      const SizedBox(height: 5),
                      CustomButton(
                        onPressed: () {},
                        text: 'أضافة منتح',
                        hight: 35,
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
