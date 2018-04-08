#!/usr/bin/env node

const fs = require('fs');
const colors = require('colors');
const util = require('util');
const path = require('path');
const mkdirp = require('mkdirp');


const dotFilesBasedir = './dotfiles';

const files = [
  '/[etc/profile]',
  '/[etc/bash.bashrc]',
  '/[etc/profile.d/shared-objects.sh]',
  '/[etc/profile.d/ps1-module.sh]',
  '~/[.config/i3/config]'
];


const repoPathRegExp = /\[(.*)\]/;

class API {
  static async gather() {
    let f;
    let hostPath;
    let repoPath;

    for (f of files) {
      if (f.startsWith('~')) {
        f = f.replace(/~/, process.env.HOME);
      }

      hostPath = f.replace(/\[|\]/g, '');
      repoPath = path.resolve(dotFilesBasedir, repoPathRegExp.exec(f)[1]);

      // we make sure it's present on the host
      if (!fs.existsSync(hostPath)) {
        console.log(`"${hostPath}" NOT FOUND! (passing)`.red);
        continue;
      }

      // if the file is found, we remove the local repo one first if it exists
      // removal
      if (fs.existsSync(repoPath)) {
        fs.unlinkSync(repoPath);
      }

      let dirPath = repoPath;
      if (!dirPath.endsWith('/')) {  // it's a file,
                                     // we create it's parent directory
        dirPath = path.dirname(dirPath);
      }
      mkdirp.sync(dirPath);

      // we copy the file from host to repo
      const rstream = fs.createReadStream(hostPath);
      const wstream = fs.createWriteStream(repoPath);
      rstream.pipe(wstream);

      ((stream, hostPath) => {
        stream.on('finish', () => {
          wstream.end();
          console.log(`"${hostPath}" fetched~`.green);
        });
      })(wstream, hostPath);
    }
  }
}


API[process.argv[2]]();
