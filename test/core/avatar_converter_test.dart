import 'package:flutter_test/flutter_test.dart';
import 'package:hamsafar/core/constants/icons.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';

void main() {
  group('AvatarConverter', () {
    test('uses one registry for every persisted avatar identifier', () {
      for (final entry in avatarIconRegistry.entries) {
        final icon = AvatarConverter.stringToIconData(
          avatarName: entry.key,
        );

        expect(icon, entry.value);
        expect(AvatarConverter.iconDataToString(iconData: icon), entry.key);
      }
    });

    test('falls back to the legacy tent avatar for unknown values', () {
      final fallback = avatarIconRegistry['tent'];

      expect(
        AvatarConverter.stringToIconData(avatarName: 'unknown-avatar'),
        fallback,
      );
      expect(AvatarConverter.iconDataToString(iconData: fallback!), 'tent');
    });

    test('picker list is derived from the registry', () {
      expect(avatarIcons, avatarIconRegistry.values.toList());
    });
  });
}
