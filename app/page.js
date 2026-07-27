export default function Home() {
  return (
    <main className="lp">
      <h1 className="visually-hidden">
        東京で買う時代から、船橋で収益を作る時代へ
      </h1>

      <div className="lp__image">
        <img
          src="/img/1.png"
          alt="東京で1室買うなら船橋で1棟。想定利回り6パーセント台、高い賃料実績"
          width="1298"
          height="1212"
        />
      </div>

      <div className="lp__image">
        <img
          src="/img/2.png"
          alt="無料個別相談予約フォーム"
          width="1448"
          height="1086"
          loading="lazy"
        />
      </div>

      <div className="lp__image">
        <img
          src="/img/3.png"
          alt="東京は守りのフェーズ、船橋は攻めのフェーズ。増やすなら船橋"
          width="1024"
          height="1536"
          loading="lazy"
        />
      </div>
    </main>
  );
}
