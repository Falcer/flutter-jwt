import React from "react";

let jwt: string | undefined = undefined;

function auth() {
  return jwt;
}

function setAuth(token: string) {
  jwt = token;
}

export function useAuth() {
  return [auth, setAuth] as const;
}
