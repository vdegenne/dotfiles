#!/usr/bin/env node

const fs = require('fs');
const colors = require('colors');
const util = require('util');
const path = require('path');
const mkdirp = require('mkdirp');

const {getAllFiles, getPaths, hostAndRepoPaths, hostNeedsUpdate} =
    require('./util');

const repoRootDirpath = path.resolve('dotfiles');
const dotFilesBasedir = './dotfiles';
const localPathRegExp = /\[(.*)\]/;


class Manager {
  static async gather() {
    for (const p of await getPaths()) {
      let {hostPath, repoPath} = await hostAndRepoPaths(p);
      const isASet = hostPath.endsWith('/') ? true : false;

      // check existence before proceeding
      if (!fs.existsSync(hostPath)) {
        console.error(`NOT FOUND ${hostPath}`.red);
        continue;
      }

      // host
      const hostDirpath = isASet ? hostPath : path.dirname(hostPath);

      // repo
      repoPath = path.resolve(repoRootDirpath, repoPath);
      const repoDirpath = isASet ? repoPath : path.dirname(repoPath);


      // the file(s) to save
      let files = [];
      if (isASet) {
        files = files.concat(await getAllFiles(hostPath));
      } else {
        files.push(path.basename(hostPath));
      }
      // if no files, pass
      if (!files.length) {
        continue;
      }

      // we create the repo directory
      mkdirp.sync(repoDirpath);

      // we transfert the files
      for (const file of files) {
        const hostFile = fs.createReadStream(path.join(hostDirpath, file));
        const repoFile = fs.createWriteStream(path.join(repoDirpath, file));

        hostFile.pipe(repoFile).on('finish', (o) => {
          console.info(`U ${hostPath + (isASet ? file : '')}`.green);
          hostFile.close();
          repoFile.close();
        });
      }
    }
  }



  static async update() {
    const paths = await getPaths();

    for (const p of paths) {
      let {hostPath, repoPath} = await hostAndRepoPaths(p);
      repoPath = path.join(repoRootDirpath, repoPath);
      if (await hostNeedsUpdate(hostPath, repoPath)) {
        console.log(hostPath);
      }
    }
  }
}
// for playing outside
exports.Manager = Manager;



/** COMMAND-LINE EXECUTION */
(async() => {
  try {
    if (process.argv.length < 3) {
      throw new Error('Needs name of the function.'.red);
    }
    if (Manager[process.argv[2]] === undefined) {
      throw new Error(`The function doesn't exist.`.red);
    }
    await Manager[process.argv[2]]();
  } catch (e) {
    console.error(e.message);
    process.exit(1);
  }
})();