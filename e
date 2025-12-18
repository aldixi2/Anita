<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Para ti 💙</title>
  <style>
    :root{
      --bg1:#0b1020;
      --bg2:#1a1b3a;
      --card:rgba(255,255,255,.08);
      --border:rgba(255,255,255,.18);
      --text:#f8fafc;
      --muted:rgba(248,250,252,.75);
      --accent:#ff4d8d;
      --accent2:#7c3aed;
      --shadow: 0 20px 60px rgba(0,0,0,.45);
      --r:24px;
    }

    *{box-sizing:border-box;margin:0;padding:0}
    body{
      min-height:100vh;
      font-family: system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
      color:var(--text);
      background:
        radial-gradient(circle at 20% 10%, rgba(124,58,237,.35), transparent 50%),
        radial-gradient(circle at 80% 30%, rgba(255,77,141,.35), transparent 55%),
        linear-gradient(160deg, var(--bg1), var(--bg2));
      overflow:hidden;
    }

    /* Corazones flotando */
    .hearts{
      position:fixed; inset:0;
      pointer-events:none;
      overflow:hidden;
      z-index:1;
    }
    .heart{
      position:absolute;
      bottom:-40px;
      font-size:22px;
      opacity:.9;
      filter: drop-shadow(0 8px 12px rgba(0,0,0,.35));
      animation: floatUp linear forwards;
    }
    @keyframes floatUp{
      0%{ transform:translateY(0) translateX(0) scale(.8) rotate(0deg); opacity:0; }
      10%{opacity:.95}
      100%{ transform:translateY(-120vh) translateX(var(--drift)) scale(1.2) rotate(25deg); opacity:0; }
    }

    .wrap{
      position:relative;
      z-index:2;
      min-height:100vh;
      display:grid;
      place-items:center;
      padding:24px;
    }

    .card{
      width:min(680px, 100%);
      background:var(--card);
      border:1px solid var(--border);
      border-radius:var(--r);
      box-shadow:var(--shadow);
      backdrop-filter: blur(16px);
      padding:28px;
      text-align:center;
    }

    .badge{
      display:inline-flex;
      align-items:center;
      gap:10px;
      padding:10px 14px;
      border-radius:999px;
      background:rgba(255,255,255,.08);
      border:1px solid rgba(255,255,255,.15);
      margin-bottom:18px;
      font-size:14px;
      color:var(--muted);
    }

    h1{
      font-size: clamp(28px, 4vw, 44px);
      letter-spacing:-.02em;
      margin-bottom:10px;
    }
    p{
      font-size: clamp(16px, 2.2vw, 18px);
      line-height:1.6;
      color:var(--muted);
      margin: 0 auto 18px;
      max-width: 54ch;
    }

    .name{
      color: #fff;
      font-weight:700;
      background: linear-gradient(90deg, #fff, #ffd1e3);
      -webkit-background-clip:text;
      background-clip:text;
      -webkit-text-fill-color:transparent;
    }

    .btns{
      display:flex;
      gap:12px;
      justify-content:center;
      flex-wrap:wrap;
      margin-top:18px;
    }
    button{
      border:none;
      border-radius:16px;
      padding:12px 16px;
      font-size:16px;
      font-weight:650;
      cursor:pointer;
      color:#fff;
      background: linear-gradient(135deg, var(--accent), var(--accent2));
      box-shadow: 0 14px 35px rgba(255,77,141,.22);
      transition: transform .15s ease, filter .15s ease;
    }
    button:active{ transform: scale(.98); }
    .ghost{
      background:rgba(255,255,255,.08);
      border:1px solid rgba(255,255,255,.18);
      box-shadow:none;
      color:rgba(255,255,255,.92);
    }

    .note{
      margin-top:14px;
      font-size:13px;
      color:rgba(248,250,252,.65);
    }

    .toast{
      position:fixed;
      left:50%;
      bottom:24px;
      transform:translateX(-50%);
      background:rgba(17,24,39,.75);
      border:1px solid rgba(255,255,255,.16);
      backdrop-filter: blur(14px);
      border-radius:16px;
      padding:12px 14px;
      color:#fff;
      box-shadow: 0 18px 50px rgba(0,0,0,.35);
      opacity:0;
      pointer-events:none;
      transition: opacity .2s ease, transform .2s ease;
      z-index:3;
      max-width:min(560px, 92vw);
    }
    .toast.show{
      opacity:1;
      transform:translateX(-50%) translateY(-6px);
    }
  </style>
</head>
<body>

  <div class="hearts" id="hearts"></div>

  <main class="wrap">
    <section class="card">
      <div class="badge">💙 Solo tú + este mensaje</div>

      <h1>Hola, <span class="name">mi persona especial</span> ✨</h1>

      <p>
        No sé cómo explicarlo… pero desde que llegaste,
        hay días en los que todo se siente más bonito 🤍
        <br><br>
        Solo pasaba a decirte que… <b>me importas</b>.
      </p>

      <div class="btns">
        <button onclick="abrazo()">Abrázame 🤍</button>
        <button class="ghost" onclick="mas()">Otro mensajito 💌</button>
      </div>

      <div class="note">
        (Si estás leyendo esto… ya ganaste mi corazón 😌💙)
      </div>
    </section>
  </main>

  <div class="toast" id="toast"></div>

  <script>
    // Generador de corazones flotando
    const hearts = document.getElementById("hearts");
    const emojis = ["💙","💜","💗","💖","💘","🤍","❤️"];

    function spawnHeart(){
      const h = document.createElement("div");
      h.className = "heart";
      h.textContent = emojis[Math.floor(Math.random()*emojis.length)];

      const left = Math.random()*100;
      const size = 16 + Math.random()*22;
      const dur = 4 + Math.random()*5;
      const drift = (Math.random()*120 - 60).toFixed(0) + "px";

      h.style.left = left + "vw";
      h.style.fontSize = size + "px";
      h.style.animationDuration = dur + "s";
      h.style.setProperty("--drift", drift);

      hearts.appendChild(h);
      setTimeout(() => h.remove(), dur*1000);
    }

    // Más cantidad al inicio para que se vea wow
    for(let i=0;i<18;i++){
      setTimeout(spawnHeart, i*120);
    }
    setInterval(spawnHeart, 250);

    // Toast bonito
    const toast = document.getElementById("toast");
    function showToast(msg){
      toast.textContent = msg;
      toast.classList.add("show");
      setTimeout(()=> toast.classList.remove("show"), 2200);
    }

    function abrazo(){
      showToast("Te mando un abrazo de esos que duran y curan 🤍✨");
    }
    function mas(){
      const msgs = [
        "Si te pienso… es porque me nace 💙",
        "Hoy también te elegí, sin que lo sepas 😌",
        "Eres calma… y también emoción 💗",
        "Que tu día sea suave, bonito y contigo 🌙"
      ];
      showToast(msgs[Math.floor(Math.random()*msgs.length)]);
    }
  </script>
</body>
</html>
