import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> args) async {
  print('🚀 Applying your Flutter starter_pro template...');

  final currentProjectDir = Directory.current;
  print('📂 Current project directory: ${currentProjectDir.path}');

  // ✅ استخدم مسار النسبي داخل الحزمة
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final templateDir = Directory(p.join(scriptDir.path, '..', 'template'));

  print('📦 Looking for template in: ${templateDir.path}');

  if (!templateDir.existsSync()) {
    print('❌ Template directory does not exist.');
    exit(1);
  }

  await copyDirectory(templateDir, currentProjectDir);
  print('✅ Template copied to project directory.');
  print('💡 Now run: flutter pub get');
}

Future<void> copyDirectory(Directory src, Directory dst) async {
  if (!await dst.exists()) await dst.create(recursive: true);

  await for (var entity in src.list(recursive: false)) {
    final newPath = p.join(dst.path, p.basename(entity.path));
    if (entity is Directory) {
      await copyDirectory(entity, Directory(newPath));
    } else if (entity is File) {
      await File(newPath).writeAsBytes(await entity.readAsBytes());
    }
  }
}
