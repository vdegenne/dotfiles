#!/usr/bin/env node

const fs = require('fs');
const colors = require('colors');
const util = require('util');
const path = require('path');
const mkdirp = require('mkdirp');

const {getAllFiles, getPaths, hostAndRepoPaths, hostNeedsUpdate} =
    require('./util');

const repoDirpath = path.resolve('dotfiles');
const dotFilesBasedir = './dotfiles';
const localPathRegExp = /\[(.*)\]/;


class Manager {
  static async gather(paths) {
    let f;
    let isASet;
    let hostPath, hostDir;
    let localPath, localDir;

    for (f of files) {
      if (f.startsWith('~')) {
        f = f.replace(/~/, process.env.HOME);
      }

      // hostPath & hostDir (the computer)
      hostPath = f.replace(/\[|\]/g, '');
      isASet = hostPath.endsWith('/') ? true : false;
      hostDir = isASet ? hostPath : path.dirname(hostPath);

      // localPath & localDir (saving repository)
      localPath = path.resolve(dotFilesBasedir, localPathRegExp.exec(f)[1]);
      localDir = isASet ? localPath : path.dirname(localPath);

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

      // we check if the directory of the set or the file to transert exists
      let elementToTransfert = isASet ? hostDir : `${hostDir}/${files[0]}`;
      let elementExists;
      try {
        elementExists = fs.existsSync(elementToTransfert);
      } catch (e) {
        if (e.code == 'ENOENT') {
          elementExists = true;
        } else {
          throw new Error('something went wrong');
        }
      }
      if (!elementExists) {
        console.log(`"${hostPath}" NOT FOUND! (passing)`.red);
        continue;
      }

      // we create the local directory
      mkdirp.sync(localDir);


      files.forEach(f => {
        const rstream = fs.createReadStream(path.resolve(hostDir, f));
        const wstream = fs.createWriteStream(path.resolve(localDir, f));
        rstream.pipe(wstream);

        ((stream, hostPath) => {
          stream.on('finish', () => {
            wstream.end();
            console.log(`"${hostPath}" fetched~`.green);
          });
        })(wstream, hostPath);
      });
    }
  }



  static async update() {
    const paths = await getPaths();

    for (const p of paths) {
      let {hostPath, repoPath} = await hostAndRepoPaths(p);
      repoPath = path.join(repoDirpath, repoPath);
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