/// Making [StatefulWidget] prettier and less boilerplate.
library appstate_widget;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
part 'src/app_behavior.dart';
part 'src/app_image.dart';
part 'src/app_log.dart';
part 'src/app_route.dart';
part 'src/app_state.dart';
part 'src/app_builder.dart';
part 'src/app_extension.dart';
part 'src/app_button.dart';
part 'src/app_model.dart';

/// Define [JSON] Type as a shortcut for [Map<String, dynamic>].
typedef JSON = Map<String, dynamic>;
