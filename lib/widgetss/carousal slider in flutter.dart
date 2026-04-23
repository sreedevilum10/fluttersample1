import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarousalSliderDemo extends StatefulWidget {
  @override
  State<CarousalSliderDemo> createState() => _CarousalSliderDemoState();
}

class _CarousalSliderDemoState extends State<CarousalSliderDemo> {
  List<String> images = [
    "https://images.unsplash.com/photo-1773332585956-2d0e8ac80cb6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDF8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxfHx8ZW58MHx8fHx8",
    "https://images.unsplash.com/photo-1776785044825-57390a892be8?q=80&w=1026&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://plus.unsplash.com/premium_photo-1764177093378-63d4b0eb06cf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw0OHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1769701185833-9e96053b527e?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];
  int currentIndex = 0;
 CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SLIDER")),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                //height: MediaQuery.of(context).size.height,
                height: 600,
               //autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(seconds: 2),
                viewportFraction: .7,
                onPageChanged: (index, v) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: images.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(item),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return GestureDetector(
                    onTap: (){
                      controller.animateToPage(index);
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index ? Colors.white : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
