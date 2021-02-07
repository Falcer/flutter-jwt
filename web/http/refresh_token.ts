import axios from "axios";

export function refresh_token() {
  return axios.post("http://127.0.0.1:8080/refresh", null, {
    withCredentials: true,
  });
}
