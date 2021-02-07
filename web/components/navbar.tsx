import Link from "next/link";
export default function Navbar() {
  return (
    <>
      <nav>
        <Link href="/">
          <a>Home</a>
        </Link>
        <div>
          <Link href="/login">
            <a>Login</a>
          </Link>
          <Link href="/register">
            <a>Register</a>
          </Link>
        </div>
      </nav>
      <style jsx>{`
        nav {
          display: flex;
          justify-content: space-between;
          height: 64px;
        }
        nav a {
          display: inline-block;
          padding: 8px 24px;
          text-decoration: underline;
        }
      `}</style>
    </>
  );
}
