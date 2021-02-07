import axios from "axios";

export function login(username: string, password: string) {
  return axios.post(
    "http://127.0.0.1:8080/login",
    {
      username,
      password,
    },
    {
      withCredentials: true,
    }
  );
}
