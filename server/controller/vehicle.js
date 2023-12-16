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

exports.getVehicle = async ctx => {
  const { userId, licenseNumber } = ctx.request.body;

  let $selectVehicle = `select * from vehicle where license_number like "%${licenseNumber}%" and user_id = "${userId}" order by create_time desc`
  console.log("$selectVehicle:", $selectVehicle);
  await model.operateSql($selectVehicle).then(res => {
    for (let i = 0; i < res.length; i++) {
      if (res[i].photos) {
        res[i].photos = JSON.stringify(JSON.parse(res[i].photos).map(item => `http://localhost:3000${item}`))
      }
    }
    console.log("!!!!", res);
    ctx.body = {
      code: 20000,
      msg: '查询成功',
      data: res
    }
  }).catch(err => {
    console.log(err)
    ctx.body = {
      code: -1,
      msg: '查询失败'
    }
  })
}

exports.updateVehicle = async ctx => {
  const { id, licenseNumber, brand, photos, color, parking } = ctx.request.body
  let updateParts = [];
  if (brand) {
    updateParts.push(`brand='${brand}'`)
  };
  if (photos) {
    updateParts.push(`photos='${photos}'`)
  };
  if (color) {
    updateParts.push(`color='${color}'`)
  };
  updateParts.push(`parking=${parking}`);
  let updateSetClause = updateParts.join(',');
  let $updateVehicle = `update vehicle set licenseNumber="${licenseNumber}", ${updateSetClause} where id="${id}"`;

  await model.operateSql($updateVehicle).then(res => {
    ctx.body = {
      code: 20000,
      msg: '更新成功'
    }
  }).catch(err => {
    ctx.body = {
      code: -1,
      msg: '更新失败'
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