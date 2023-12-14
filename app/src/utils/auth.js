import cookies from 'js-cookie'

const TokenKey = 'App-Token'

export function getToken() {
  return cookies.get(TokenKey);
}

export function setToken(token) {
  return cookies.set(TokenKey, token, { expires: 30 });
}

export function removeToken() {
  return cookies.remove(TokenKey);
}
