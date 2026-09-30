from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app import models, schemas

router = APIRouter()

@router.get("/", response_model=list[schemas.SkillResponse])
def list_skills(db: Session = Depends(get_db)):
    return db.query(models.Skill).all()

@router.post("/", response_model=schemas.SkillResponse, status_code=201)
def create_skill(data: schemas.SkillBase, db: Session = Depends(get_db)):
    skill = models.Skill(**data.model_dump())
    db.add(skill)
    db.commit()
    db.refresh(skill)
    return skill

@router.delete("/{skill_id}", status_code=204)
def delete_skill(skill_id: int, db: Session = Depends(get_db)):
    skill = db.query(models.Skill).filter(models.Skill.id == skill_id).first()
    if not skill:
        raise HTTPException(status_code=404, detail="Skill not found")
    db.delete(skill)
    db.commit()
