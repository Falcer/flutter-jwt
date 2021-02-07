import { useAuth } from "@/hooks/use-auth";
import { login } from "@/http/login";
import React from "react";
import { useMutation } from "react-query";

export default function Login() {
  const [username, setUsername] = React.useState("");
  const [password, setPassword] = React.useState("");
  const [auth, setAuth] = useAuth();

  const loginMutation = useMutation(
    (loginState: { username: string; password: string }) =>
      login(loginState.username, loginState.password),
    {
      onSuccess: (data, variables, context) => {
        setAuth(data.data.data.access_token);
      },
      onError: (error: any, variables, context) => {
        alert(error.response.data.message);
      },
      onSettled: (data, error, variables, context) => {
        setUsername("");
        setPassword("");
      },
    }
  );

  const handleLogin = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (username === "" || password === "") {
      alert("username or password can't blank");
      return;
    }
    loginMutation.mutate({ username, password });
  };
  return (
    <div className="container">
      <form onSubmit={(e) => handleLogin(e)}>
        <div>
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            placeholder="Username"
          />
        </div>
        <div>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Password"
          />
        </div>
        <button type="submit" disabled={loginMutation.isLoading}>
          Login
        </button>
      </form>
      <style jsx>{`
        .container {
          height: calc(100vh - 64px);
          display: grid;
          place-items: center;
        }
        form input {
          margin-bottom: 24px;
          padding: 16px 32px;
          border: none;
          background-color: rgba(0, 0, 0, 0.08);
          border-radius: 8px;
          outline: none;
          letter-spacing: 0.8px;
        }
        form button[type="submit"] {
          width: 100%;
          padding: 16px 32px;
          border: none;
          background-color: rgba(0, 0, 0, 0.8);
          border-radius: 8px;
          outline: none;
          cursor: pointer;
          color: #fff;
          font-weight: bold;
          letter-spacing: 1.3px;
        }
      `}</style>
    </div>
  );
}
