import 'dart:io';

/// Base Directory that is the root of the Apps internal file system
Directory tgtbDir(Directory root) {
  return Directory('${root.path}/tgtb');
}

/// Base Directory; contains all the pages created by the user.
Directory pagesDir(Directory root) {
  var path = '${root.path}/tgtb/pages';
  return Directory(path);
}

/// Base Directory; if the user manually drops something into
/// the FileSystem that does not fit in it lands here.
Directory otherDir(Directory root) {
  var path = '${root.path}/tgtb/other';
  return Directory(path);
}

void makeSureBaseDirectoriesExist(Directory root) {
  if (!dirExists(tgtbDir(root))) {
    createDir(tgtbDir(root));
    createDir(pagesDir(root));
    createDir(otherDir(root));
  }
  if (!dirExists(pagesDir(root))) {
    createDir(pagesDir(root));
  }
  if (!dirExists(otherDir(root))) {
    createDir(otherDir(root));
  }
}

void createDir(Directory dir) {
  dir.createSync();
  print('created: $dir');
}

bool dirExists(Directory dir) {
  if (dir.existsSync()) {
    print('found: $dir');
    return true;
  } else {
    print('not found: $dir');
    return false;
  }
}
