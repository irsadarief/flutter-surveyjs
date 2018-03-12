// Add material design package.
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import './services/survey.dart';

// void main() => runApp(new MyApp());

void main() async {

  // print('Hello World'); // Prints Hello World! to the console.
  // Testing the getActiveSurveys function.
  // We wait for the surveys data to arrive
  List activeSurveys = await SurveyProvider.getActiveSurveys();
  // Before printing it to the Console
  print(activeSurveys);

  runApp(new MaterialApp(
    home: new MyApp(activeSurveys),
  ));
}

class MyApp extends StatelessWidget {

  // This is a list of material colors. Feel free to add more colors, it won't break the code
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  final List<String> _images = [];

  // The underscore before a variable name marks it as a private variable.
  final List _activeSurveys;

  // This is a constructor in Dart. We are assigning the value passed to the constructor
  // to the _activeSurveys variable
  MyApp(this._activeSurveys);

  // This widget is the root of your application.

  /*
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter & SurveyJS Demo APP',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter & SurveyJS Demo APP'),//new Center(
        // The Text widget is wrapped in a center widget to center it on the screen
        //child: new Text('Hello World!'),
      //),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildBody() {
    return new Container(
      // A top margin of 56.0. A left and right margin of 8.0. And a bottom margin of 0.0.
      margin: const EdgeInsets.fromLTRB(8.0, 56.0, 8.0, 0.0),
      child: new Column(
        // A column widget can have several widgets that are placed in a top down fashion
        children: <Widget>[
          _getAppTitleWidget(),
          _getListViewWidget()
        ],
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return new Text(
      'Flutter & SurveyJS Demo APP',
      style: new TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24.0),
    );
  }


  Widget _getListViewWidget() {
    // We want the ListView to have the flexibility to expand to fill the
    // available space in the vertical axis
    return new Flexible(
        child: new ListView.builder(
            // The number of items to show
            itemCount: _activeSurveys.length,
            // Callback that should return ListView children
            // The index parameter = 0...(itemCount-1)
            itemBuilder: (context, index) {
              // Get the currency at this position
              final Map activeSurvey = _activeSurveys[index];
              print(activeSurvey);

              // Get the icon color. Since x mod y, will always be less than y,
              // this will be within bounds.
              final MaterialColor color = _colors[index % _colors.length];

              return _getListItemWidget(activeSurvey, color);
            }));
  }

  CircleAvatar _getLeadingWidget() {
    return new CircleAvatar(
      backgroundImage: new NetworkImage("https://cdn.pixabay.com/photo/2017/05/15/23/48/survey-2316468_960_720.png"),
    );
  }

  Text _getTitleWidget(String surveyName) {
    return new Text(
      surveyName,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Text _getSubtitleWidget(String surveyDatetime) {
    // var formatter = new DateFormat('dd-MM-yyyy HH:mm');
    // String formatted = formatter.format(surveyDatetime);
    return new Text(surveyDatetime);
  }

  ListTile _getListTile(Map activeSurvey, MaterialColor color) {
    return new ListTile(
      leading: _getLeadingWidget(),
      title: _getTitleWidget(activeSurvey['Name']),
      subtitle: _getSubtitleWidget(activeSurvey['CreatedAt']),
      isThreeLine: true,
    );
  }

  Container _getListItemWidget(Map activeSurvey, MaterialColor color) {
    // Returns a container widget that has a card child and a top margin of 5.0
    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: _getListTile(activeSurvey, color),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
