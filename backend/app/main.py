from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import engine, Base
from app.routers import profile, projects, skills, experience

Base.metadata.create_all(bind=engine)

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
