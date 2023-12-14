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
