#!/usr/bin/node

// This program makes use of 
const http = require('http')

if (process.env.pair === undefined) {
  throw new Error('"pair" environment variable required')
}
const pair = process.env.pair

async function main() {
  const cryptoname = pair.split('/')[0]
  const lastValues = JSON.parse(await fetch(`http://localhost:36005/${pair}?lasts=2`))
  const currentValue = parseFloat(lastValues.pop())
  let changeValue = await fetch(`http://localhost:36005/${pair}?last=5m`)
  let changeColor = 'grey';

  if (changeValue) {
    changeValue = parseFloat(changeValue)
    if (currentValue !== changeValue) {
      changeColor = currentValue > changeValue ? '#00ff00' : '#ef5350'
    }
  }

  console.log(`<span color="${changeColor}">${cryptoname}</span> <span>${currentValue}</span>`)
}

main();

function fetch(link) {
  return new Promise(function (resolve) {
    http.get(link, function (response) {
      let data = '';
      response.on('data', function (chunk) {
        data += chunk;
      })
      response.on('end', function () {
        resolve(data);
      })
    })
  })
}