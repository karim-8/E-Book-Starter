

import 'package:flutter/material.dart';
import 'package:gesturesstarterproject/models/article_model.dart';
import 'package:gesturesstarterproject/painting/screen_drawing.dart';
import 'package:gesturesstarterproject/utilities/alert_view_dialogue.dart';
import 'package:gesturesstarterproject/utilities/constants.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: Constants.appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ///
  var _pageNumber = 0;

  ///
  var _changeColor = true;

  ///
  var _scale = 1.0;

  ///
  var _rotate = 0;

  ///
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: _changeColor ? Colors.brown : Colors.grey,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.rotate_left,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _rotate < 3 ? _rotate++ : _rotate = 0;
                });
              },
            ),
          ],
        ),
        body: Builder(
          builder: (contexts)=>
           SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: _changeColor ? Colors.white : Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  coverImageView(),
                  bookTopic(contexts),
                  changePageView(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: new Container(
          color: _changeColor ? Colors.white : Colors.grey,
          height: 40.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${_pageNumber + 1}",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )
            ],
          ),
        ),
    );
  }

  Widget coverImageView() {
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
        child: Container(
          height: 200,
          color: Colors.black,
          child: Image.asset(
            getTopicsList().image,
            fit: BoxFit.fill,
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      );
  }

  Widget bookTopic(BuildContext buildContext) {
    return ClipRect(
            child: new CustomPaint(
              painter: new ScreenDrawing(points: _points),
              size: Size.infinite,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          getTopicsList().topicHeader,
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(
                          getTopicsList().topicBody,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget changePageView() {
    return Expanded(
        flex: 2,
        child: Container(
          color: _changeColor ? Colors.white : Colors.grey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "images/previous-arrow.png",
                    fit: BoxFit.fill,
                    height: 50,
                    width: 40,
                  ),
                  Image.asset(
                    "images/forward-arrow.png",
                    fit: BoxFit.fill,
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  ArticleModel getTopicsList() {
    final items = ArticleModel.getData();
    final location = items[_pageNumber];
    return location;
  }
}
