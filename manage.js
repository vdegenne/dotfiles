#!/usr/bin/env node

const fs = require('fs');
const colors = require('colors');
const util = require('util');
const path = require('path');
const mkdirp = require('mkdirp');


const dotFilesBasedir = './dotfiles';

const files = [
  // bash & shells
  '/[etc/profile]',
  '/[etc/bash.bashrc]',
  '/[etc/profile.d/shared-objects.sh]',
  '/[etc/profile.d/ps1-module.sh]',
  // X & i3
  '~/[.config/i3/config]',
  '/[etc/i3status.conf]',
  '~/[.Xresources]',
  // fonts
  '/[usr/share/fonts/Monaco.ttf]',
  // Editors
  '~/[.emacs]',
  '~/[.emacs.d/snippets/]',
  '~/[.config/Code/User/]',
  // IRC
  '~/[.irssi/]'
];


const localPathRegExp = /\[(.*)\]/;

class API {
  static async gather() {
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
        files = files.concat(await API.getAllFiles(hostPath));
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

  static async getAllFiles(path) {
    try {
      const filter = fs.readdirSync(path).filter(
          f => !fs.lstatSync(`${path}/${f}`).isDirectory());
      return filter;
    } catch (e) {
      if (e.code == 'ENOENT') {
        return [];
      }
    }
  }
}


API[process.argv[2]]();


exports.api = API;
