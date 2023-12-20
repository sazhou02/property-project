/**
 * 小驼峰命名(camelCase)转换为下划线命名(snake_case)
 * @param {*} str 
 * @returns 
 */
function camelToSnake(str) {
  // 正则表达式匹配小写字母后跟大写字母的组合
  return str.replace(/([a-z])([A-Z])/g, function(match, p1, p2) {
    // 将匹配到的大写字母前添加下划线并转换为小写
    return p1 + "_" + p2.toLowerCase();
  });
}

module.exports = {
  camelToSnake
}