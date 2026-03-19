import http from 'k6/http';
import { sleep } from 'k6';


export const options = {
  vus: 10,       // จำนวน virtual users
  duration: '10s' // ระยะเวลา run test
};

export default function () {
  http.get('http://localhost:3000/prediction/generate');
  sleep(0.1);
}
