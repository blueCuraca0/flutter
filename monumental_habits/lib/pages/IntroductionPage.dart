import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monumental_habits/pages/SplashScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constants/CColors.dart';

class IntroductionPage extends StatefulWidget {
  final Function setCurrentPage;

  const IntroductionPage(this.setCurrentPage, {super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final List<Widget> _pages = [
    Image.asset(
      "lib/images/Introduction 1.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "lib/images/Introduction 2.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "lib/images/Introduction 3.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "lib/images/Introduction 4.png",
      fit: BoxFit.cover,
    ),
  ];

  final PageController _controller = PageController();

  bool _onLastPage = false;

  void _nextPage() {
    setState(() {
      _controller.nextPage(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut);
    });
  }

  Widget _buildNavigationBar() {
    return _onLastPage
        ? GetStartedButton(widget.setCurrentPage)
        : NavigationBarWithDots(widget.setCurrentPage, _pages, _controller, _nextPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (page) {
            setState(() {
              _onLastPage = (page == _pages.length - 1);
            });
          },
          children: _pages,
        ),
        Container(
          alignment: const Alignment(0, 0.8),
          child: _buildNavigationBar(),
        ),
        SplashScreen(),
      ]),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  final Function setCurrentPage;

  const GetStartedButton(this.setCurrentPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setCurrentPage(1);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: CColors.orange,
          padding:
              const EdgeInsets.only(left: 70, right: 70, top: 15, bottom: 15),
          child: const Text(
            "Get Started",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: CColors.purple),
          ),
        ),
      ),
    );
  }
}

class NavigationBarWithDots extends StatelessWidget {
  final Function setCurrentPage;
  final Function nextPage;
  final List<Widget> _pages;
  final PageController _controller;

  const NavigationBarWithDots(
      this.setCurrentPage, this._pages, this._controller, this.nextPage,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            setCurrentPage(1);
          },
          child: const Text(
            "skip",
            style:
                TextStyle(fontWeight: FontWeight.w500, color: CColors.purple),
          ),
        ),
        SmoothPageIndicator(
          controller: _controller,
          count: _pages.length,
          effect: const ExpandingDotsEffect(
            spacing: 10,
            activeDotColor: CColors.purple,
            dotColor: CColors.yellow,
          ),
        ),
        InkWell(
          onTap: () {
            nextPage();
          },
          child: const Text(
            "next",
            style:
                TextStyle(fontWeight: FontWeight.w500, color: CColors.purple),
          ),
        ),
      ],
    );
  }
}
