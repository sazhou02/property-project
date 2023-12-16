const model = require('../lib/mysql.js')
const fs = require("fs");



exports.createVehicle = async ctx => {
  const { licenseNumber, brand, photos, color, parking, userId } = ctx.request.body;
  let $createVehicle = `insert into vehicle (license_number, brand, photos, color, parking, user_id, create_time) value ("${licenseNumber}","${brand ? brand : ''}",'${photos ? photos : ''}', "${color ? color : ''}", "${parking}", "${userId}", "${(new Date()).getTime()}")`
  await model.operateSql($createVehicle).then(res => {
    console.log("success:", res);
    ctx.body = {
      code: 20000,
      msg: '创建成功'
    }
  }).catch(err => {
    console.log("err:", err)
    ctx.body = {
      code: -1,
      msg: '创建失败'
    }
  })
}

exports.uploadImage = async ctx => {
  const imgData = ctx.request.body;
  //过滤data:URL
  const path = [];
  for (let i = 0; i < imgData.length; i++) {
    let base64Data = imgData[i].replace(/^data:image\/\w+;base64,/, "");
    let dataBuffer = new Buffer(base64Data, 'base64');
    let randomName = '/img/vehicle' + (new Date()).getTime() + parseInt(Math.random() * 8999 + 10000) + '.png';
    await fs.writeFile('./files' + randomName, dataBuffer, function (err) {
      if (err) {
        console.log(err);
      }
    });
    path[i] = randomName
  }

  ctx.body = {
    code: 20000,
    msg: '更新成功',
    data: {
      path: path
    }
  }
}