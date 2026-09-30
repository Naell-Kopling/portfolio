"""Seed database with Leonardo's portfolio data."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))

from app.database import engine, SessionLocal, Base
from app.models import Profile, Project, Skill, Experience

Base.metadata.create_all(bind=engine)
db = SessionLocal()

for model in [Profile, Project, Skill, Experience]:
    db.query(model).delete()

db.add(Profile(
    name="Leonardo",
    title="Software Developer",
    bio="BINUS University student passionate about building modern software solutions.",
    email="joshua.natanael@binus.ac.id",
    github="https://github.com/Naell-Kopling",
    instagram="@xyznaell_",
))

db.add_all([
    Project(title="Portfolio App", description="Full-stack portfolio with FastAPI, Web & Flutter", tech_stack="Python, FastAPI, Flutter, HTML/CSS", github_url="https://github.com/Naell-Kopling/portfolio"),
    Project(title="Hermes Coding Lab", description="Coding experiments and learning projects", tech_stack="Python", github_url="https://github.com/Naell-Kopling/hermes-coding-lab"),
])

db.add_all([
    Skill(name="Python", category="Language", level=70),
    Skill(name="FastAPI", category="Framework", level=60),
    Skill(name="Flutter", category="Framework", level=50),
    Skill(name="HTML/CSS", category="Frontend", level=65),
    Skill(name="JavaScript", category="Language", level=55),
    Skill(name="Git", category="Tool", level=65),
])

db.add(Experience(role="Student", company="BINUS University Online", period="Current", description="Undergraduate student studying software engineering"))

db.commit()
db.close()
print("Database seeded!")
