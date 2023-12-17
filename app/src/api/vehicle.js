import http from './index';

export const getVehicle = data => {
  return http.post('/getVehicle', data)
}

export const createVehicle = data => {
  return http.post('/vehicle', data)
}

export const deleteVehicle = data => {
  return http.post('/deleteVehicle', data)
}

export const uploadVehicleImage = data => {
  return http.post('/vehiclePhoto', data)
}