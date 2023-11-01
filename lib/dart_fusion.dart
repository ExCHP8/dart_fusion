/// A library that brings together a harmonious blend of essential tools, utilities, and components designed to supercharge your Dart projects.
library dart_fusion;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_fusion/src/d_process/d_process_io.dart'
    if (dart.library.js) 'package:dart_fusion/src/d_process/d_process.dart'
    if (dart.library.html) 'package:dart_fusion/src/d_process/d_process.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

part 'src/d_behavior.dart';
part 'src/d_exceptions.dart';
part 'src/d_image.dart';
part 'src/d_log.dart';
part 'src/d_widget.dart';
part 'src/d_builder.dart';
part 'src/d_extensions.dart';
part 'src/d_button.dart';
part 'src/d_models.dart';
part 'src/d_overlay.dart';
part 'src/d_typedefs.dart';
part 'src/d_parse.dart';
part 'src/d_textarea.dart';
part 'src/d_annotation.dart';
part 'src/d_service.dart';
part 'src/d_runner.dart';
part 'src/d_option.dart';

/// A class for initializing DartFusion auto generation.
class DartFusion {
  /// A function to run auto generation used in `Dart Fusion CLI`.
  ///
  /// ```dart
  /// DartFusion.runner([
  ///   AssetRunner(),
  ///   ModelRunner(),
  ///   LocalizeRunner()
  /// ]);
  /// ```
  static Future<void> runner(List<DRunner> runner,
      {bool onDebug = true}) async {
    try {
      for (var value in runner) {
        await value.run(onDebug: onDebug);
      }
    } catch (e) {
      print(e);
    }
  }

  /// List of available [Locale] to be translated in [LocalizeRunner].
  static const List<Locale> locales = [
    Locale('af'),
    Locale('sq'),
    Locale('am'),
    Locale('ar'),
    Locale('hy'),
    Locale('as'),
    Locale('ay'),
    Locale('az'),
    Locale('bm'),
    Locale('eu'),
    Locale('be'),
    Locale('bn'),
    Locale('bho'),
    Locale('bs'),
    Locale('bg'),
    Locale('ca'),
    Locale('ceb'),
    Locale('zh-CN'),
    Locale('zh'),
    Locale('zh-TW'),
    Locale('co'),
    Locale('hr'),
    Locale('cs'),
    Locale('da'),
    Locale('dv'),
    Locale('doi'),
    Locale('nl'),
    Locale('en'),
    Locale('eo'),
    Locale('et'),
    Locale('ee'),
    Locale('fil'),
    Locale('fi'),
    Locale('fr'),
    Locale('fy'),
    Locale('gl'),
    Locale('ka'),
    Locale('de'),
    Locale('el'),
    Locale('gn'),
    Locale('gu'),
    Locale('ht'),
    Locale('ha'),
    Locale('haw'),
    Locale('he'),
    Locale('hi'),
    Locale('hmn'),
    Locale('hu'),
    Locale('is'),
    Locale('ig'),
    Locale('ilo'),
    Locale('id'),
    Locale('ga'),
    Locale('it'),
    Locale('ja'),
    Locale('jv'),
    Locale('kn'),
    Locale('kk'),
    Locale('km'),
    Locale('rw'),
    Locale('gom'),
    Locale('ko'),
    Locale('kri'),
    Locale('ku'),
    Locale('ckb'),
    Locale('ky'),
    Locale('lo'),
    Locale('la'),
    Locale('lv'),
    Locale('ln'),
    Locale('lt'),
    Locale('lg'),
    Locale('lb'),
    Locale('mk'),
    Locale('mai'),
    Locale('mg'),
    Locale('ms'),
    Locale('ml'),
    Locale('mt'),
    Locale('mi'),
    Locale('mr'),
    Locale('mni-Mtei'),
    Locale('lus'),
    Locale('mn'),
    Locale('my'),
    Locale('ne'),
    Locale('no'),
    Locale('ny'),
    Locale('or'),
    Locale('om'),
    Locale('ps'),
    Locale('fa'),
    Locale('pl'),
    Locale('pt'),
    Locale('pa'),
    Locale('qu'),
    Locale('ro'),
    Locale('ru'),
    Locale('sm'),
    Locale('sa'),
    Locale('gd'),
    Locale('nso'),
    Locale('sr'),
    Locale('st'),
    Locale('sn'),
    Locale('sd'),
    Locale('si'),
    Locale('sk'),
    Locale('sl'),
    Locale('so'),
    Locale('es'),
    Locale('su'),
    Locale('sw'),
    Locale('sv'),
    Locale('tl'),
    Locale('tg'),
    Locale('ta'),
    Locale('tt'),
    Locale('te'),
    Locale('th'),
    Locale('ti'),
    Locale('ts'),
    Locale('tr'),
    Locale('tk'),
    Locale('ak'),
    Locale('uk'),
    Locale('ur'),
    Locale('ug'),
    Locale('uz'),
    Locale('vi'),
    Locale('cy'),
    Locale('xh'),
    Locale('yi'),
    Locale('yo'),
    Locale('zu')
  ];
}
