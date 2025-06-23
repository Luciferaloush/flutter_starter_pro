import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> args) async {
  print('🚀 Applying your Flutter starter_pro template...');

  final currentProjectDir = Directory.current;
  print('Current project directory: ${currentProjectDir.path}');

  // ⚠️ استبدل هذا المسار بالمسار الفعلي لمجلد template عندك
  final templateDir = Directory(
      p.join(Platform.environment['USERPROFILE']!, 'flutter_templates', 'starter_pro'));

  print('Looking for template in: ${templateDir.path}');

  if (!await templateDir.exists()) {
    print('❌ Template directory does not exist at: ${templateDir.path}');
    print('➡️ تأكد من أنك وضعت ملفات القالب في هذا المسار');
    exit(1);
  }

  for (final folder in ['lib', 'assets', 'test']) {
    final src = Directory(p.join(templateDir.path, folder));
    final dst = Directory(p.join(currentProjectDir.path, folder));
    print('Checking folder "$folder": ${src.path}');

    if (await src.exists()) {
      await copyDirectory(src, dst);
      print('✅ $folder copied.');
    } else {
      print('⚠️ $folder folder not found in template.');
    }
  }

  for (final fileName in ['.gitignore', 'analysis_options.yaml']) {
    final src = File(p.join(templateDir.path, fileName));
    final dst = File(p.join(currentProjectDir.path, fileName));

    if (await src.exists()) {
      await dst.writeAsString(await src.readAsString());
      print('✅ $fileName copied.');
    } else {
      print('⚠️ $fileName file not found in template.');
    }
  }

  final srcPubspec = File(p.join(templateDir.path, 'pubspec.yaml'));
  final dstPubspec = File(p.join(currentProjectDir.path, 'pubspec.yaml'));

  if (await srcPubspec.exists() && await dstPubspec.exists()) {
    final dstLines = await dstPubspec.readAsLines();
    final projectNameLine = dstLines.firstWhere(
          (line) => line.trim().startsWith('name:'),
      orElse: () => '',
    );

    final srcLines = await srcPubspec.readAsLines();
    final filteredLines = srcLines.where((line) => !line.trim().startsWith('name:')).toList();

    final newPubspecContent = (projectNameLine.isNotEmpty ? projectNameLine + '\n' : '') +
        filteredLines.join('\n');

    await dstPubspec.writeAsString(newPubspecContent);
    print('✅ pubspec.yaml replaced (project name preserved).');
  } else {
    print('⚠️ pubspec.yaml not found in template or project.');
  }

  print('\n🎉 Done! Now run: flutter pub get');
}

Future<void> copyDirectory(Directory src, Directory dst) async {
  if (!await dst.exists()) {
    await dst.create(recursive: true);
  }
  await for (var entity in src.list(recursive: false)) {
    final newPath = p.join(dst.path, p.basename(entity.path));
    if (entity is Directory) {
      await copyDirectory(entity, Directory(newPath));
    } else if (entity is File) {
      await File(newPath).writeAsBytes(await entity.readAsBytes());
    }
  }
}