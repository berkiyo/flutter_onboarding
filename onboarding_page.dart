import 'package:flutter/material.dart';
import 'package:noter/pages/intro_page_1.dart';
import 'package:noter/pages/intro_page_2.dart';
import 'package:noter/pages/intro_page_3.dart';
import 'package:noter/pages/notes_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

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


          const Spacer(),

          // smooth page indicator
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2, // 20% of screen height
              width: double.infinity, // Full width
              alignment: const Alignment(0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // MARK: DOT INDICATOR
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotColor: Theme.of(context).colorScheme.secondary, // Inactive dot color
                      activeDotColor: Theme.of(context).colorScheme.inversePrimary, // Active dot color
                      dotHeight: 12.0,
                      dotWidth: 12.0,
                    ),
                  ),
            
                  // Next or done (? :)
                  onLastPage 
                    // IF WE ARE AT THE LAST PAGE, GO TO HOME PAGE :)
                    // MARK: DONE BUTTON
                    ? GestureDetector(
                      onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isFirstLaunch', false);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const NotesPage()),
                          );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary, // Button color
                          borderRadius: BorderRadius.circular(30.0), // Capsule shape
                        ),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface, // Text color
                            fontWeight: FontWeight.w600,// Text color
                            fontSize: 16.0,
                          ),
                        ),
                        )
                      )
                      // PRESS NEXT TO CONTINUE TO NEXT PAGE... 
                      // MARK: NEXT BUTTON
                      : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500), 
                          curve: Curves.easeIn
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary, // Button color
                          borderRadius: BorderRadius.circular(30.0), // Capsule shape
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface, 
                            fontWeight: FontWeight.w600,// Text color
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}