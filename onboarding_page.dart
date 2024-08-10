import 'package:flutter/material.dart';
import 'package:noter/pages/intro_page_1.dart';
import 'package:noter/pages/intro_page_2.dart';
import 'package:noter/pages/intro_page_3.dart';
import 'package:noter/pages/notes_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  // Controller to keep track of which page we are on
  final PageController _controller = PageController();

  // Keep track of the page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onLastPage = (value == 2); // if we are on the last page, set to true
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // smooth page indicator
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip button
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2); // jump to the last page
                  },
                  child: const Text("Skip")
                ),

                // Dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                // Next or done (? :)
                onLastPage 
                  // IF WE ARE AT THE LAST PAGE, GO TO HOME PAGE :)
                  ? GestureDetector(
                    onTap: () {
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context) {
                          return NotesPage();
                        }));
                    },
                    child: const Text("Done")
                    // PRESS NEXT TO CONTINUE TO NEXT PAGE... 
                  ) : GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500), 
                        curve: Curves.easeIn
                      );
                    },
                    child: const Text("Next")
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}