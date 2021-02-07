import { useAuth } from "@/hooks/use-auth";
import axios from "axios";

export function getUsers() {
  const [auth, setAuth] = useAuth();
  if (!auth()) {
    throw Error("Access Token invalid");
  }
  return axios.get("http://127.0.0.1:8080/users", {
    headers: {
      Authorization: `Bearer ${auth()}`,
    },
  });
}
