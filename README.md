# fasti

A new Flutter project.

### Code Generation Commands

~~Run the following commands to generate the necessary code:

1. **Activate `flutter_gen` for asset generation**:
   ```bash
   dart pub global activate flutter_gen
   ```

2. **Generate code for Freezed, JsonSerializable, Injectable, and Drift**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Generate localization files**:
   ```bash
   flutter gen-l10n
   ```

4. **Generate launcher icons**:
   ```bash
   flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons* 
   ```

4. **Generate assets**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

~~To do before deploying:

1. **Change the env in main**:
2. **Comment the /.env and decomment the /assets/.env in pubspec.yaml**: