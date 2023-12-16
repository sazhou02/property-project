import http from './index';

export const createVehicle = data => {
  return http.post('/vehicle', data)
}

export const uploadVehicleImage = data => {
  return http.post('/vehiclePhoto', data)
}