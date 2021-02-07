import { getUsers } from "@/http/user";
import { Key } from "react";
import { useQuery } from "react-query";

export default function Home() {
  const { isLoading, isError, data, error } = useQuery(
    "getUsers",
    getUsers,
    {}
  );
  if (isLoading) return <div>Loading . . .</div>;
  if (isError) return <div>Error {error}</div>;
  return (
    <>
      <ul>
        {data.data.data.map((e: any, key: Key) => {
          return (
            <li key={key}>
              {e.id} - {e.username} - {e.name} - {e.email}
            </li>
          );
        })}
      </ul>
    </>
  );
}
