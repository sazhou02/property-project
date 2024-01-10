import http from './index';

export const getPayment = data => {
    return http.post('/getPayment', data)
}

export const createPayment = data => {
  return http.post('/payment', data)
}

export const deletePayment = data => {
  return http.post('/deletePayment', data)
}

export const updatePayment = data => {
  return http.post('/updatePayment', data)
}
