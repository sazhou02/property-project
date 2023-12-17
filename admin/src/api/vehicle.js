import http from './index';

export const getVehicle = data => {
    return http.post('/getVehicle', data)
}