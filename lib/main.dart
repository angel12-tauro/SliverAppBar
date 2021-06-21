import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

final List<Color> listaColores = [
  Colors.black,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.orange,
  Colors.blueAccent,
  Colors.blueGrey,
  Colors.green,
    Colors.black,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.orange,
  Colors.blueAccent,
  Colors.blueGrey,
  Colors.green
];

    return ChangeNotifierProvider(
      create: (_) => Providers(),
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                floating: true,
                delegate: _SliverCustomHeaderDelegate(
                  minheight: 100,
                  maxheight: 150,
                  child: _ChildHeader(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(
                    listaColores.length,
                    (index) => Container(
                      margin: EdgeInsets.all(10),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: listaColores[index].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class _ChildHeader extends StatelessWidget {
  final List<String> listNameCategory = [

    'Productos',
    'Servicios',
      'Productos',
    'Servicios',
  

  ];

  _ChildHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.grey,
              blurRadius: 5,
            )
          ],
          color: Colors.blue,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.blue])),
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Shopping Online',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    listNameCategory.length,
                    (index) => _ItemHorizontalHeader(
                          index: index,
                          name: listNameCategory[index],
                        ))),
          )
        ],
      ),
    );
  }
}

class _ItemHorizontalHeader extends StatelessWidget {
  final String name;
  final int index;

  const _ItemHorizontalHeader({Key key, this.name, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
  
    bool color;
    Color colorText;

    final itemSeleccionado = Provider.of<Providers>(context).itemSeleccionado;

    if (itemSeleccionado == index) {
      color = true;
      colorText = Colors.black; 
    } else {
      color = false;
      colorText = Colors.white; 
    }

    return GestureDetector(
      onTap: () {
        Provider.of<Providers>(context, listen: false).itemSeleccionado = index;
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
        color: (color)?Colors.white:Colors.transparent,
        borderRadius: BorderRadius.circular(20)
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 20,
            color:  colorText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minheight;
  final double maxheight;
  final Widget child;

  _SliverCustomHeaderDelegate(
      {@required this.minheight,
      @required this.maxheight,
      @required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxheight;

  @override
  double get minExtent => minheight;

  @override
  bool shouldRebuild(_SliverCustomHeaderDelegate oldDelegate) {
    return maxheight != oldDelegate.maxheight ||
        minheight != oldDelegate.minheight ||
        child != oldDelegate.child;
  }
}

class Providers extends ChangeNotifier {
  int _itemSeleccionado = 0;

  int get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado(int valor) {
    this._itemSeleccionado = valor;
    notifyListeners();
  }
}
