import http from './index';

export const createVehicle = data => {
  return http.post('/vehicle', data)
}