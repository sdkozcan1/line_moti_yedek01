import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mor_motti_01/category.dart';
import 'package:mor_motti_01/favoritPage.dart';
import 'package:mor_motti_01/jsonModel.dart';
import 'package:mor_motti_01/splashScreen.dart';
import 'package:page_transition/page_transition.dart';

final List<Map<String, dynamic>> Textlist = [
  {"id": 1, "text": "text1", "kategori": "ktg1"},
  {"id": 2, "text": "text2", "kategori": "ktg2"},
  {"id": 3, "text": "text3", "kategori": "ktg3"},
  {"id": 4, "text": "text4", "kategori": "ktg4"},
];

const textFavoriBox = "favoriBox";
Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(textFavoriBox);
  runApp(MaterialApp(
    initialRoute: '/splash',
    routes: {
      '/splash': (context) => SplashScreen(),
      '/home': (context) => MainPage(),

      // Add other routes for your app screens here
    },
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<MyData> futureData;

  @override
  void initState() {
    super.initState();

    /* Json datası */
    futureData = loadMyData();
    /* ------------------------ */
  }

  int currentIndex = 0;

/* mix Text */
  mixText() {
    if (currentIndex < Textlist.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
  }

/* ------------------------ ----------------  */

/* -------- */

  Widget getIcon(int index) {
    var box = Hive.box(textFavoriBox);
    if (box.containsKey(currentIndex)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }

  void onFavoritePress(int index) {
    if (box.containsKey(currentIndex)) {
      box.delete(currentIndex);
      print("delete:${currentIndex}: \n ${Textlist[currentIndex]}");

      return;
    }
    box.put(index, Textlist[currentIndex]);
    print("put :${currentIndex}: \n ${Textlist[currentIndex]}");
  }

  String kategoriName = "tema";
  var fontName = [
    'ABeeZee',
    'Acme',
    'Advent Pro',
    'Alata',
    'Allan',
    'Amatic SC',
    'Anton',
    'Archivo',
    'Arvo',
    'Pacifico'
  ];

  @override
  Widget build(BuildContext context) {
    /* Cihazın Sizenı Almak İÇin olan Kod */
    final screenSize = MediaQuery.of(context).size;
    /* ------------------ */

    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/pexels-mark-yu-18178746.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              /* ANASAYFANIN ÜSTÜNE GELEN SİYAH TRANSPARAN. YAZININ DAHA İYİ OKUNMASI İÇİN */

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    /* ANASAYFA ELEMNTLERİN OLDUĞU KISIM */
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /* Profil Photo and İCONLAR */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /* PROFİL PHOTO AND YAZI */
                            profilPhotoandText(),
                            /* Twoıcon üçgen ve menü */
                            twoIcon(context)
                          ],
                        ),
                        /* Main page motivasyon Textt */

                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: '05 ',
                              style: GoogleFonts.aboreto(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '\n MAR 2024',
                                ),
                                TextSpan(
                                  text:
                                      "\n    ${Textlist[currentIndex]["text"]}",
                                ),
                              ],
                            ),
                          ),
                        ),

                        /* MAIN PAGE 3 ICON */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  /* Motivasyon textini değiştiren fonksiyon */
                                  mixText();
                                });
                              },
                              icon: ImageIcon(
                                AssetImage("assets/img/sync (1).png"),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: FavoritePage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.open_in_new,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        onFavoritePress(currentIndex);
                                      });
                                    },
                                    icon: getIcon(currentIndex),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              /* Ana kapama işaretleri silme */
            );
          },
        ),
      ),
    );
  }

  Container profilPhotoandText() {
    return Container(
      width: 200,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {},
            child: CircleAvatar(
                backgroundImage: AssetImage("assets/img/pp.jpeg"), radius: 25),
          ),
          RichText(
            text: TextSpan(
                text: "Mutlu Günler",
                style: TextStyle(fontSize: 20),
                children: [
                  TextSpan(text: "\n Sıdıka", style: TextStyle(fontSize: 20)),
                ]),
          ),
        ],
      ),
    );
  }

  Container twoIcon(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              print("tıklandııı");
              /* ÜÇGEN TIKLANDIĞINDA AÇILACAK SHOWMODAL BOTTOMSHEETMODAL */
              sMB(context);
            },
            icon: ImageIcon(
              AssetImage("assets/img/Group 38.png"),
              color: Colors.white,
            ),
          ),
          /* Menu icon tıklandığında kategori sayfasını açarsın */
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CategoryPage(),
                    ),
                  );
                });
              },
              icon: ImageIcon(
                AssetImage(
                  "assets/img/Group 37.png",
                ),
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  Future<dynamic> sMB(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: 400,
          height: 400,
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        color: Colors.white,
                      ),
                      Center(
                        child: Text(
                          "Ayarlar",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Kilitleri Aç"),
                      ),
                    ],
                  ),
                ),
              ),
              /* Tema Nameleri  ve tema butonları tıklandığında tema name değişir ve ona göre tasarım oluşur*/
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        debugPrint("TEMALAR");
                        kategoriName == "";

                        setState(() {
                          kategoriName = "tema";
                        });
                      },
                      child: const Text(
                        'Temalar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        kategoriName == "";

                        setState(() {
                          kategoriName = "canli";
                        });
                        debugPrint("Canlı");
                      },
                      child: const Text(
                        'Canlı',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        kategoriName == "";
                        debugPrint("SESLER");
                        setState(() {
                          kategoriName = "sesler";
                        });
                      },
                      child: const Text(
                        'Sesler',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        kategoriName == "";

                        setState(() {
                          kategoriName = "font";
                        });
                      },
                      child: const Text(
                        'Fontlar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              /* Hangi tema namedeyse ona göre tasarım gelir ona göre seçenekler gelen kod */
              FutureBuilder(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        /* Item Count temaname göre item count length*/
                        itemCount: kategoriName == "tema"
                            ? snapshot.data!.tema.length
                            : kategoriName == "canli"
                                ? snapshot.data!.canli.length
                                : kategoriName == "sesler"
                                    ? snapshot.data!.sesler.length
                                    : kategoriName == "font"
                                        ? fontName.length
                                        : 0, // Burada 0 olarak setlenmiştir, değişebilir.
                        /* -------------- ---------------- */

                        itemBuilder: (context, index) {
                          /* tema naemi tema veya canlıysa gelen seçenekler */
                          if (kategoriName == "tema" ||
                              kategoriName == "canli") {
                            MyTheme tema = snapshot.data!.tema[index];
                            MyTheme canli = snapshot.data!.canli[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          kategoriName == "tema"
                                              ? tema.imgUrl
                                              : canli.imgUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 175,
                                    left: 25,
                                    child: Center(
                                      child: Text(
                                        kategoriName == "tema"
                                            ? tema.photoAciklama
                                            : canli.photoAciklama,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                            /* ----------------------------- */
                          } else if (kategoriName == "sesler") {
                            MyTheme sesler = snapshot.data!.sesler[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundImage:
                                          AssetImage(sesler.imgUrl),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${sesler.name}',
                                    style:
                                        GoogleFonts.lato(color: Colors.white),
                                  ),
                                )
                              ],
                            );
                          } else if (kategoriName == "font") {
                            return Center(
                              child: Container(
                                width: 120,
                                child: ListTile(
                                  title: index >= 0 && index < fontName.length
                                      ? Text(
                                          fontName[index],
                                          style: GoogleFonts.getFont(
                                            fontName[index],
                                            textStyle: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "Invalid Index: $index for fontName list",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          } else {
                            // Diğer durumlar için gerekli kontrolleri ekleyin
                            return Container();
                          }
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
