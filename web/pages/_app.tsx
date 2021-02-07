import Navbar from "@/components/navbar";
import { useAuth } from "@/hooks/use-auth";
import { refresh_token } from "@/http/refresh_token";
import React from "react";
import { QueryClient, QueryClientProvider } from "react-query";
import { Hydrate } from "react-query/hydration";
import "../styles/globals.css";

const queryClient = new QueryClient();

function Application({ Component, pageProps }) {
  const [auth, setAuth] = useAuth();
  React.useEffect(() => {
    refresh_token()
      .then((val) => {
        const { data } = val;
        setAuth(data.data.access_token);
      })
      .catch((err) => {
        // Don't do something
      });
  }, []);
  return (
    <QueryClientProvider client={queryClient}>
      <Hydrate state={pageProps.dehydratedState}>
        <Navbar />
        <Component {...pageProps} />
      </Hydrate>
    </QueryClientProvider>
  );
}

export default Application;
