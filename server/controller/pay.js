const model = require('../lib/mysql.js')

exports.createPayment = async ctx => {
  const { payType, payName, amount, payMethod, notes, userId } = ctx.request.body;
  const payStatus = 0;
  let $createPayment = `insert into payment (pay_type, pay_name, amount, pay_method, pay_status, notes, user_id, create_time) value ("${payType}", "${payName}", "${amount ? amount : ''}",'${payMethod ? payMethod : ''}',"${payStatus}", "${notes ? notes : ''}", "${userId}", "${(new Date()).getTime()}")`
  await model.operateSql($createPayment).then(res => {
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

exports.getPayment = async ctx => {
  const { payName, userId } = ctx.request.body;

  let $selectPayment = `select payment.*,user.nick_name from payment join user on payment.user_id=user.id where pay_name like "%${payName}%" ${userId ? 'and user_id =' + userId : ''} order by create_time desc`
  console.log("$selectVehicle:", $selectPayment);
  await model.operateSql($selectPayment).then(res => {
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

exports.deletePayment = async ctx => {
  const { id } = ctx.request.body;
  let $deletePayment = `delete from payment where id = ${id}`
  try {
    await model.operateSql($deletePayment);
    ctx.body = {
      code: 20000,
      msg: '删除成功'
    }
  } catch (error) {
    ctx.body = {
      code: -1,
      msg: '删除失败'
    }
  }
}

exports.updatePayment = async ctx => {
  const { id, payType, amount, payMethod, payStatus, notes, userId } = ctx.request.body
  let updateParts = [];
  if (payType) {
    updateParts.push(`pay_type='${payType}'`)
  };
  if (amount) {
    updateParts.push(`amount='${amount}'`)
  };
  if (payMethod) {
    updateParts.push(`pay_method='${payMethod}'`)
  };
  if (payStatus) {
    updateParts.push(`payStatus='${1}'`)
  };
  if (notes) {
    updateParts.push(`notes='${notes}'`)
  };
  if (userId) {
    updateParts.push(`user_id='${userId}'`)
  };
  let updateSetClause = updateParts.join(',');
  let $updatePayment = `update payment set ${updateSetClause} where id="${id}"`;

  await model.operateSql($updatePayment).then(res => {
    ctx.body = {
      code: 20000,
      msg: '更新成功'
    }
  }).catch(err => {
    console.log("error:", err);
    ctx.body = {
      code: -1,
      msg: '更新失败'
    }
  })
}
