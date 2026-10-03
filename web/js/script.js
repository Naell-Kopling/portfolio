const API = 'https://naell-api.vercel.app/api';

// ponytail: one fetch helper, no abstraction needed yet
const load = async (endpoint, el, render) => {
  try {
    const data = await (await fetch(`${API}/${endpoint}/`)).json();
    el.innerHTML = data.map(render).join('');
  } catch { el.innerHTML = '<p class="error">Failed to load</p>'; }
};

document.addEventListener('DOMContentLoaded', () => {
  load('skills', document.getElementById('skills-grid'), s => `
    <div class="skill-card">
      <span class="skill-name">${s.name}</span>
      <span class="skill-level">${s.level}%</span>
      <div class="skill-bar"><div style="width:${s.level}%"></div></div>
    </div>`);

  load('projects', document.getElementById('projects-grid'), (p,i) => `
    <article class="project-card">
      <span class="project-num">${String(i+1).padStart(2,'0')}</span>
      <h3>${p.title}</h3>
      <p>${p.description || ''}</p>
      <div class="tags">${(p.tech_stack||'').split(',').map(t=>`<span>${t.trim()}</span>`).join('')}</div>
      ${p.github_url ? `<a href="${p.github_url}" target="_blank" rel="noopener">View Code →</a>` : ''}
    </article>`);

  // cursor glow: lerp follower, skip on touch / reduced motion
  // ponytail: rAF + transform only, no per-frame layout reads beyond x/y
  if (matchMedia('(hover: hover) and (prefers-reduced-motion: no-preference)').matches) {
    const glow = document.createElement('div');
    glow.className = 'cursor-glow';
    document.body.appendChild(glow);
    let gx = -300, gy = -300, cx = -300, cy = -300;
    addEventListener('pointermove', e => { cx = e.clientX; cy = e.clientY; });
    (function tick() {
      gx += (cx - gx) * 0.12;
      gy += (cy - gy) * 0.12;
      glow.style.transform = `translate(${gx - 150}px, ${gy - 150}px)`;
      requestAnimationFrame(tick);
    })();
  }

  // active nav link per visible section
  const navio = new IntersectionObserver(es => es.forEach(e => {
    if (e.isIntersecting) document.querySelectorAll('.nav-links a').forEach(a =>
      a.classList.toggle('active', a.hash === '#' + e.target.id));
  }), { rootMargin: '-40% 0px -55% 0px' });
  document.querySelectorAll('section[id]').forEach(sec => navio.observe(sec));

  // scroll reveal: one observer, CSS does the rest
  // ponytail: global observer, per-element unobserve is enough here
  const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (!reduce) {
    const io = new IntersectionObserver(es => es.forEach(e => {
      if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); }
    }), { threshold: 0.12 });
    document.querySelectorAll('.reveal').forEach(el => io.observe(el));
  } else {
    document.querySelectorAll('.reveal').forEach(el => el.classList.add('in'));
  }
});
