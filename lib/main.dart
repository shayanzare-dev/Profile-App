import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const MyApp());

// setting project
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String languageCode = 'fa';
  Languages _language = Languages.en;
  bool themeMode = true;

  void _toggleThemeMode() {
    setState(() {
      if (themeMode == true) {
        themeMode = false;
      } else {
        themeMode = true;
      }
    });
  }

  void _updateSelectedLanguageState() {
    setState(() {
      if (_language == Languages.en) {
        _language = Languages.fa;
      } else {
        _language = Languages.en;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // لیستی از قابلیت های پشتبانی کننده پکیج بین المللی سازی
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // لیستی از زبان های ساپورت شده اپ ما
      supportedLocales: AppLocalizations.supportedLocales,
      // زبان پیش فرض اپ ما
      locale: Locale(_language == Languages.en
          ? languageCode = 'en'
          : languageCode = 'fa'),
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: themeMode
          ? AppTheme.dark().getTheme(languages: _language)
          : AppTheme.light().getTheme(languages: _language),
      home: MyHomePage(
        language: _language,
        title: 'Flutter Demo Home Page',
        toggleThemeMode: _toggleThemeMode,
        updateSelectedLanguageState: _updateSelectedLanguageState,
      ),
    );
  }
}

// user interface
class MyHomePage extends StatefulWidget {
  final String title;
  final Languages language;
  final void Function() toggleThemeMode;
  final void Function() updateSelectedLanguageState;
  const MyHomePage(
      {super.key,
      required this.title,
      required this.language,
      required this.toggleThemeMode,
      required this.updateSelectedLanguageState});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SkillType skillType = SkillType.photoShop;
  bool heartState = false;
  void updateState(SkillType type) {
    setState(() {
      skillType = type;
    });
  }

  void changeHeartState() {
    setState(() {
      if (heartState == true) {
        heartState = false;
      } else {
        heartState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? displayLarge = Theme.of(context).textTheme.displayLarge;
    TextStyle? bodySmall = Theme.of(context).textTheme.bodySmall;
    TextStyle? displaySmall = Theme.of(context).textTheme.displaySmall;
    final AppLocalizations appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            appLocalization.profileTitle,
            style: displayLarge,
          ),
          actions: [
            IconButton(
                onPressed: widget.toggleThemeMode,
                icon: const Icon(Icons.change_circle_outlined)),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: IconButton(
                onPressed: changeHeartState,
                icon: heartState ? heartFill() : heart(),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // start layout widgets
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(
                      'assets/images/profile_image.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(appLocalization.name, style: displayLarge),
                        const SizedBox(height: 2),
                        Text(appLocalization.job, style: bodySmall),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              CupertinoIcons.location_solid,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Text(
                              appLocalization.location,
                              style: displaySmall,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 6),
                ]),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                  child: Text(
                    style: bodySmall,
                    appLocalization.summaty,
                  )),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLocalization.selectedLanguage,
                      style: bodySmall,
                    ),
                    SizedBox(
                      width: 270,
                      child: CupertinoSlidingSegmentedControl<Languages>(
                          groupValue: widget.language,
                          thumbColor: Theme.of(context).primaryColor,
                          children: {
                            Languages.en: Text(appLocalization.english),
                            Languages.fa: Text(appLocalization.farsi),
                          },
                          onValueChanged: (value) {
                            widget.updateSelectedLanguageState();
                          }),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 12, 30, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(appLocalization.skillText,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(width: 2),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      size: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SkillItem(
                          type: skillType,
                          onTap: () => updateState(SkillType.photoShop),
                          title: appLocalization.photoshopTitle,
                          imagePath: 'assets/images/app_icon_01.png',
                          isActive: skillType == SkillType.photoShop,
                          shadowColor: Colors.blue.shade600),
                      SkillItem(
                        type: skillType,
                        onTap: () => updateState(SkillType.lightRoom),
                        title: appLocalization.lightroomTitle,
                        imagePath: 'assets/images/app_icon_02.png',
                        isActive: skillType == SkillType.lightRoom,
                        shadowColor: Colors.blue,
                      ),
                      SkillItem(
                          type: skillType,
                          onTap: () => updateState(SkillType.afterEffect),
                          title: appLocalization.afterEffectTitle,
                          imagePath: 'assets/images/app_icon_03.png',
                          isActive: skillType == SkillType.afterEffect,
                          shadowColor: Colors.blue.shade900),
                      SkillItem(
                          type: skillType,
                          onTap: () => updateState(SkillType.illustrator),
                          title: appLocalization.illustrator,
                          imagePath: 'assets/images/app_icon_04.png',
                          isActive: skillType == SkillType.illustrator,
                          shadowColor: const Color.fromARGB(255, 188, 66, 0)),
                      SkillItem(
                          type: skillType,
                          onTap: () => updateState(SkillType.adobeXd),
                          title: appLocalization.abobeXdTitle,
                          imagePath: 'assets/images/app_icon_05.png',
                          isActive: skillType == SkillType.adobeXd,
                          shadowColor: Colors.purple.shade600),
                    ]),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalization.personalInformation,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                        decoration: InputDecoration(
                      labelText: appLocalization.email,
                      prefixIcon: const Icon(CupertinoIcons.at),
                    )),
                    const SizedBox(height: 10),
                    TextField(
                        decoration: InputDecoration(
                      labelText: appLocalization.password,
                      prefixIcon: const Icon(CupertinoIcons.lock),
                    )),
                    const SizedBox(height: 12),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              appLocalization.save,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            )))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class SkillItem extends StatelessWidget {
  final SkillType type;
  final String imagePath;
  final String title;
  final bool isActive;
  final Color shadowColor;
  final void Function() onTap;

  const SkillItem(
      {super.key,
      required this.type,
      required this.imagePath,
      required this.title,
      required this.isActive,
      required this.shadowColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final BorderRadius defaultBorderRedius = BorderRadius.circular(8);
    return InkWell(
      borderRadius: defaultBorderRedius,
      onTap: onTap,
      child: Container(
        width: 100,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: defaultBorderRedius,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: isActive
                    ? BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: shadowColor.withOpacity(0.6),
                            blurRadius: 35),
                      ])
                    : null,
                child: Image.asset(imagePath, width: 40, height: 40)),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class AppTheme {
  static const String faPrimaryFontFamlily = 'Rokh';
  Color primaryColor = Colors.pink.shade500;
  final Color surfaceColor;
  final Color appBarColor;
  final Color scaffoldBackground;
  final Color displayLargeColor;
  final Color displaySmallColor;
  final Color bodySmallColor;
  final Brightness brightness;

  AppTheme.dark()
      : appBarColor = Colors.black,
        displayLargeColor = Colors.white,
        bodySmallColor = Colors.white,
        displaySmallColor = const Color.fromARGB(190, 215, 215, 215),
        scaffoldBackground = const Color.fromARGB(255, 30, 30, 30),
        brightness = Brightness.dark,
        surfaceColor = const Color.fromARGB(10, 255, 255, 255);

  AppTheme.light()
      : appBarColor = Colors.grey.shade300,
        displayLargeColor = Colors.black,
        displaySmallColor = const Color.fromARGB(255, 178, 178, 178),
        bodySmallColor = Colors.black.withOpacity(0.9),
        scaffoldBackground = const Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light,
        surfaceColor = const Color(0x0d000000);

  ThemeData getTheme({required Languages languages}) {
    return ThemeData(
        fontFamily: faPrimaryFontFamlily,
        dividerColor: surfaceColor,
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
            color: appBarColor,
            elevation: 0.0,
            foregroundColor: displayLargeColor),
        scaffoldBackgroundColor: scaffoldBackground,
        brightness: brightness,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(primaryColor))),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: surfaceColor,
        ),
        textTheme: languages == Languages.en
            ? enPrimaryTextTheme
            : faPrimaryTextTheme);
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.acmeTextTheme(TextTheme(
        displayLarge: TextStyle(
            color: displayLargeColor,
            fontWeight: FontWeight.w700,
            fontSize: 20),
        displaySmall: TextStyle(
            color: displaySmallColor,
            fontWeight: FontWeight.w300,
            fontSize: 12),
        bodySmall: TextStyle(
            color: bodySmallColor, fontWeight: FontWeight.w300, fontSize: 14),
      ));
  TextTheme get faPrimaryTextTheme => TextTheme(
        displayLarge: TextStyle(
            fontFamily: faPrimaryFontFamlily,
            color: displayLargeColor,
            fontWeight: FontWeight.w700,
            fontSize: 16),
        displaySmall: TextStyle(
            fontFamily: faPrimaryFontFamlily,
            color: displaySmallColor,
            fontWeight: FontWeight.w500,
            fontSize: 12),
        bodySmall: TextStyle(
          fontFamily: faPrimaryFontFamlily,
          color: bodySmallColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      );
}

enum SkillType {
  photoShop,
  lightRoom,
  afterEffect,
  illustrator,
  adobeXd;
}

enum Languages {
  en,
  fa;
}

Icon heartFill() {
  return const Icon(
    CupertinoIcons.heart_fill,
    color: Colors.red,
  );
}

Icon heart() {
  return const Icon(CupertinoIcons.heart);
}
