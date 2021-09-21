import 'dart:io';

/// Base Directory; the root of the Apps internal file system
Directory tgtbDir(Directory root) {
  return Directory('${root.path}/tgtb');
}

/// Base Directory; contains all the pages created by the user.
Directory pagesDir(Directory root) {
  var path = '${root.path}/tgtb/pages';
  return Directory(path);
}

/// Base Directory; if the user manually drops something into
/// the FileSystem that does not belong it lands here.
Directory otherDir(Directory root) {
  var path = '${root.path}/tgtb/other';
  return Directory(path);
}

void makeSureBaseDirectoriesExist(Directory root) {
  if (!tgtbDir(root).existsSync()) {
    tgtbDir(root).createSync();
    pagesDir(root).createSync();
    otherDir(root).createSync();
  }
  if (!pagesDir(root).existsSync()) {
    pagesDir(root).createSync();
  }
  if (!otherDir(root).existsSync()) {
    otherDir(root).createSync();
  }
}
