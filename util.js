const fs = require('fs');

exports.getAllFiles = async(path) => {
  try {
    const filter = fs.readdirSync(path).filter(
        f => !fs.lstatSync(`${path}/${f}`).isDirectory());
    return filter;
  } catch (e) {
    if (e.code == 'ENOENT') {
      return [];
    }
  }
};

exports.getPaths = async() => {
  return fs.readFileSync('.paths')
      .toString()
      .replace(/\r\n/g, '\n')
      .split('\n')
      .filter(l => {return l && (l.trim()[0] !== '#')})
      .map(l => {
        const path = l.match(/^[^\]]*\]/gi);
        if (!path) {
          throw new Error('The .paths file is broken.'.red);
        }
        return path[0];
      })
      .map(p => p.replace(/^~/, process.env.HOME));

};


exports.hostAndRepoPaths = async(pattpath) => {
  return {
    hostPath: pattpath.replace(/\[|\]/gi, ''),
    repoPath: pattpath.match(/\[([^\]]+)\]/i)[1]
  };
};

exports.hostNeedsUpdate = async(hostPath, repoPath) => {

  let hostStat, repoStat;

  try {
    hostStat = fs.lstatSync(hostPath);
  } catch (e) {
    if (e.code === 'ENOENT') {
      return true;  // because the file doesn't exist
    }
  }

  try {
    repoStat = fs.lstatSync(repoPath);
  } catch (e) {
    if (e.code === 'ENOENT') {
      return false;  // the file is not available, pass
    }
  }

  // we assume the host file needs an update when the size is different (not
  // very effective).
  return (hostStat.size !== repoStat.size);
}