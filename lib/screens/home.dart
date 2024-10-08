import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_app/const/constants.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/detail_page.dart';
import 'package:plant_app/widgets/extention.dart';
import 'package:plant_app/widgets/plant_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Plant> _plantList = Plant.plantList;

  bool toggleFavorite(bool isFavorited) {
    return !isFavorited;
  }

  final List<String> _plantTypes = [
    "| پیشنهادی |",
    "| پر‌بازدیدها |",
    "| گل‌های سمی |",
    "| گل‌های‌گلخانه‌ای |"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mic,
                        color: Constants.textColor,
                      ),
                      const Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            textAlign: TextAlign.start,
                            showCursor: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  right: 5,
                                ),
                                hintText: "جستجو...",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            style: TextStyle(
                              fontFamily: "Muli",
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Constants.textColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              height: 70,
              width: size.width,
              child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: _plantTypes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Text(
                        _plantTypes[index],
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontSize: 16,
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.w300,
                          color: selectedIndex == index
                              ? Constants.primaryColor
                              : Constants.textColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                reverse: true,
                itemCount: _plantList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: DetailPage(
                              plantID: _plantList[index].plantId,
                            ),
                            type: PageTransitionType.bottomToTop),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: 200,
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    bool isFavorated = toggleFavorite(
                                        _plantList[index].isFavorated);
                                    _plantList[index].isFavorated = isFavorated;
                                  });
                                },
                                icon: Icon(
                                  _plantList[index].isFavorated == true
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Constants.primaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            bottom: 50,
                            right: 50,
                            left: 50,
                            child: Image.asset(_plantList[index].imageURL),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "تومان ",
                                    style: TextStyle(
                                      fontFamily: "Muli",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    _plantList[index]
                                        .price
                                        .toString()
                                        .farsiNumber,
                                    style: TextStyle(
                                      fontFamily: "Muli",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            right: 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _plantList[index].category,
                                  style: const TextStyle(
                                    fontFamily: "Muli",
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  _plantList[index].plantName,
                                  style: const TextStyle(
                                    fontFamily: "Muli",
                                    fontSize: 16,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.only(right: 18, bottom: 15, top: 20),
                child: Text(
                  "گیاهان جدید",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              height: size.height * 0.3,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _plantList.length,
                itemBuilder: (context, index) {
                  return NewPlantWidget(
                    plantList: _plantList,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
