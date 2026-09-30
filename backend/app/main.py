import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import engine, Base, SessionLocal
from app.routers import profile, projects, skills, experience
from app import models

Base.metadata.create_all(bind=engine)

# Auto-seed on Vercel
if os.environ.get("VERCEL"):
    db = SessionLocal()
    if not db.query(models.Profile).first():
        db.add(models.Profile(name="Leonardo", title="Software Developer", bio="BINUS University student passionate about building modern software solutions.", email="joshua.natanael@binus.ac.id", github="https://github.com/Naell-Kopling", instagram="@xyznaell_"))
        db.add_all([
            models.Project(title="Portfolio App", description="Full-stack portfolio with FastAPI, Web & Flutter", tech_stack="Python, FastAPI, Flutter, HTML/CSS", github_url="https://github.com/Naell-Kopling/portfolio"),
            models.Project(title="Hermes Coding Lab", description="Coding experiments and learning projects", tech_stack="Python", github_url="https://github.com/Naell-Kopling/hermes-coding-lab"),
        ])
        db.add_all([
            models.Skill(name="Python", category="Language", level=70),
            models.Skill(name="FastAPI", category="Framework", level=60),
            models.Skill(name="Flutter", category="Framework", level=50),
            models.Skill(name="HTML/CSS", category="Frontend", level=65),
            models.Skill(name="JavaScript", category="Language", level=55),
            models.Skill(name="Git", category="Tool", level=65),
        ])
        db.add(models.Experience(role="Student", company="BINUS University Online", period="Current", description="Undergraduate student studying software engineering"))
        db.commit()
    db.close()

app = FastAPI(title="Leonardo Portfolio API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(profile.router, prefix="/api/profile", tags=["Profile"])
app.include_router(projects.router, prefix="/api/projects", tags=["Projects"])
app.include_router(skills.router, prefix="/api/skills", tags=["Skills"])
app.include_router(experience.router, prefix="/api/experience", tags=["Experience"])

@app.get("/")
def root():
    return {"message": "Leonardo Portfolio API", "docs": "/docs"}
