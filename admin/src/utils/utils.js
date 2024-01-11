export function deepClone(obj, hash = new WeakMap()) {
  if (obj instanceof Date) return new Date(obj);
  if (obj instanceof RegExp) return new RegExp(obj);
  // 处理循环引用
  if (hash.has(obj)) return hash.get(obj);

  let cloneObj;
  // 处理对象和数组
  if (obj instanceof Array) {
    cloneObj = [];
    hash.set(obj, cloneObj);
    obj.forEach((item, index) => {
      cloneObj[index] = deepClone(item, hash);
    });
  } else if (obj instanceof Object) {
    cloneObj = {};
    hash.set(obj, cloneObj);
    Object.keys(obj).forEach((key) => {
      cloneObj[key] = deepClone(obj[key], hash);
    });
  } else {
    return obj;
  }

  return cloneObj;
}

function toCamelCase(str) {
  return str.replace(/_([a-z])/g, function (g) { return g[1].toUpperCase(); });
}

export function keysToCamelCase(obj) {
  let newObj = {};
  Object.keys(obj).forEach((key) => {
      let camelCaseKey = toCamelCase(key);
      newObj[camelCaseKey] = obj[key];
  });
  return newObj;
}
