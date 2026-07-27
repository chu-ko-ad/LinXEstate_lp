import "./globals.css";

export const metadata = {
  title: "船橋 不動産投資｜無料個別相談",
  description:
    "東京で買う時代から、船橋で収益を作る時代へ。無料個別相談を受付中です。",
};

export default function RootLayout({ children }) {
  return (
    <html lang="ja">
      <body>{children}</body>
    </html>
  );
}
