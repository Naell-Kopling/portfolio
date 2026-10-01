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
      ${p.github_url ? `<a href="${p.github_url}" target="_blank">View Code →</a>` : ''}
    </article>`);
});

// ponytail: smooth scroll via CSS scroll-behavior, no JS needed
// ponytail: intersection observer removed, CSS handles animations
