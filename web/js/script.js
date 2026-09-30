const API_BASE = 'https://portfolio-backend-naell.vercel.app/api';

// Fetch skills
async function loadSkills() {
  try {
    const res = await fetch(`${API_BASE}/skills/`);
    const skills = await res.json();
    const grid = document.getElementById('skills-grid');
    
    grid.innerHTML = skills.map(skill => `
      <div class="skill-card">
        <div class="skill-name">${skill.name}</div>
        <div class="skill-category">${skill.category || 'Skill'}</div>
        <div class="skill-bar">
          <div class="skill-bar-fill" style="width: ${skill.level}%"></div>
        </div>
      </div>
    `).join('');
  } catch (e) {
    document.getElementById('skills-grid').innerHTML = '<p style="color: var(--text-muted)">Unable to load skills. Make sure backend is running.</p>';
  }
}

// Fetch projects
async function loadProjects() {
  try {
    const res = await fetch(`${API_BASE}/projects/`);
    const projects = await res.json();
    const grid = document.getElementById('projects-grid');
    
    grid.innerHTML = projects.map((project, i) => `
      <div class="project-card">
        <div class="project-num">${String(i + 1).padStart(2, '0')}</div>
        <h3 class="project-title">${project.title}</h3>
        <p class="project-desc">${project.description || ''}</p>
        <div class="project-tech">
          ${(project.tech_stack || '').split(',').map(t => `<span>${t.trim()}</span>`).join('')}
        </div>
        ${project.github_url ? `<a href="${project.github_url}" target="_blank" class="project-link">View on GitHub →</a>` : ''}
      </div>
    `).join('');
  } catch (e) {
    document.getElementById('projects-grid').innerHTML = '<p style="color: var(--text-muted)">Unable to load projects. Make sure backend is running.</p>';
  }
}

// Smooth scroll for nav links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function(e) {
    e.preventDefault();
    const target = document.querySelector(this.getAttribute('href'));
    if (target) {
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  });
});

// Intersection Observer for animations
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('.section').forEach(section => {
  observer.observe(section);
});

// Load data
document.addEventListener('DOMContentLoaded', () => {
  loadSkills();
  loadProjects();
});
