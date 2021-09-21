import 'dart:io';

import 'package:flutter_application_1/FileSystem/BaseDirectories/base_directories.dart';

extension Name on FileSystemEntity {
  String get name {
    return path.split('/').last.split(r'\').last;
  }
}

extension ListDirs on FileSystemEntity {
  List<Directory> listDirsSync() {
    var fileSystemEntity = this;
    var dirs = <Directory>[];
    if (fileSystemEntity is Directory) {
      for (var entity in fileSystemEntity.listSync()) {
        if (entity is Directory) dirs.add(entity);
      }
    }
    return dirs;
  }
}

/// Finds all FileSystemEntities that are different form Bundles, Pages
/// and Page-Content and moves them to the "other" directory.
void findAndMoveAtypicalFseInPagesDirToOtherDir(Directory root) {
  // in pagesDirectory
  var atypicalBundles = findAtypicalBundles(pagesDir(root));
  moveFileSystemEntities(atypicalBundles, otherDir(root));
  // in bundles
  var atypicalPages = <FileSystemEntity>[];
  for (var bundle in pagesDir(root).listDirsSync()) {
    atypicalPages.addAll(findAtypicalPages(bundle));
  }
  moveFileSystemEntities(atypicalPages, otherDir(root));
  // in pages
  var atypicalPageContent = <FileSystemEntity>[];
  for (var bundle in pagesDir(root).listDirsSync()) {
    for (var page in bundle.listDirsSync()) {
      atypicalPageContent.addAll(findAtypicalPageContent(page));
    }
  }
  moveFileSystemEntities(atypicalPageContent, otherDir(root));
}

/// Searches the directory for FileSystemEntities that
/// are not Bundles and returns a list of them.
List<FileSystemEntity> findAtypicalBundles(Directory dir) {
  var atypicalEntities = <FileSystemEntity>[];
  for (var bundle in dir.listSync()) {
    var wrongType = bundle is! Directory;
    var wrongName = !isBundleNameFormat(bundle.name);
    if (wrongType || wrongName) atypicalEntities.add(bundle);
  }
  return atypicalEntities;
}

/// Searches the directory for FileSystemEntities
/// that are not Pages and returns a list of them.
List<FileSystemEntity> findAtypicalPages(Directory dir) {
  var atypicalEntities = <FileSystemEntity>[];
  for (var entity in dir.listSync()) {
    var wrongType = entity is! Directory;
    var wrongName = !isPageNameFormat(entity.name);
    if (wrongType || wrongName) atypicalEntities.add(entity);
  }
  return atypicalEntities;
}

/// Searches the directory for FileSystemEntities that
/// are not Entries or Images and returns a list of them.
List<FileSystemEntity> findAtypicalPageContent(Directory dir) {
  var atypicalEntities = <FileSystemEntity>[];
  for (var entity in dir.listSync()) {
    var wrongType = entity is! File;
    var notEntry = !isEntryNameFormat(entity.name);
    var notImage = !isImageFile(entity.name);
    if (wrongType || (notEntry && notImage)) atypicalEntities.add(entity);
  }
  return atypicalEntities;
}

void moveFileSystemEntities(
    List<FileSystemEntity> entities, Directory targetDir) {
  for (var entity in entities) {
    entity.renameSync(targetDir.path + '/' + entity.name);
  }
}

/// Checks if the String has the form "yyyy-mm-dd".
bool isBundleNameFormat(String name) {
  try {
    var a = name.split('-').map(int.parse).toList();
    var correctLenght = a.length == 3;
    var isYearAD = a[0] > 0;
    var isMonth = 1 <= a[1] && a[1] <= 12;
    var isDay = 1 <= a[2] && a[2] <= 31;
    return correctLenght && isYearAD && isMonth && isDay;
  } catch (_) {
    return false;
  }
}

/// Checks if the String has the the form "page_$int".
bool isPageNameFormat(String name) {
  try {
    int.parse(name.substring(5));
    return name.substring(0, 5) == 'page_';
  } catch (_) {
    return false;
  }
}

bool isEntryNameFormat(String name) {
  return name == 'entry.json';
}

bool isImageFile(String name) {
  var fileExtension = name.split('.').last;
  switch (fileExtension) {
    case 'png':
      return true;
    default:
      return false;
  }
}
