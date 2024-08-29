import 'package:bettergas_assignment/app/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../components/elevatedbutton.dart';
import '../../../routes/app_pages.dart';
import '../../search/widgets/searchbar_widget.dart';
import '../controllers/dashboard_controller.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
        init: DashBoardController(),
        builder: (controller) {
          return Scaffold(
             drawer: SideDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: Get.height / 9,
              centerTitle: true,
              title: Image.asset(
                'assets/Logo.png',
                height: Get.height / 3.5,
                width: Get.width / 3.5,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppPages.CHECKOUT);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.SEARCH);
                      },
                      child: Container(
                        child: SearchBarWidget(
                          textEditingController:
                              controller.searchController.value,
                          isSearch: false,
                          onChanged: (value) {
                            controller.onChanged(value);
                          },
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Container(
                              width: Get.width * 0.95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/product.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Better Gas Panaf drive Dutse',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Obx(() => Text(
                            controller.selectedOption.value == 'Gas'
                                ? '₹ ${80 * controller.count.value}'
                                : '₹${180 * controller.count.value}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                      child: Text('Choose'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => controller.selectOption('Gas'),
                                child: Obx(() => Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: controller.isSelected.value
                                            ? Colors.black
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Gas',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: Get.width / 14,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    controller.selectOption('Gas + Cylinder'),
                                child: Obx(() => Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: !controller.isSelected.value
                                            ? Colors.black
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Gas + Cylinder',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      child: Text('Quantity'),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(right: 150),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: controller.decrement,
                                child: Icon(Icons.remove),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  '${controller.count}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: controller.increment,
                                child: Icon(Icons.add),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    MyButton(
                        ontap: () => {
                              Get.toNamed(AppPages.CHECKOUT),
                            },
                        text: 'Add to cart')
                  ],
                ),
              ),
            ),
          );
        });
  }
}
