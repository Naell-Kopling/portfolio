from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app import models, schemas

router = APIRouter()

@router.get("/", response_model=list[schemas.ExperienceResponse])
def list_experience(db: Session = Depends(get_db)):
    return db.query(models.Experience).all()

@router.post("/", response_model=schemas.ExperienceResponse, status_code=201)
def create_experience(data: schemas.ExperienceBase, db: Session = Depends(get_db)):
    exp = models.Experience(**data.model_dump())
    db.add(exp)
    db.commit()
    db.refresh(exp)
    return exp

@router.delete("/{exp_id}", status_code=204)
def delete_experience(exp_id: int, db: Session = Depends(get_db)):
    exp = db.query(models.Experience).filter(models.Experience.id == exp_id).first()
    if not exp:
        raise HTTPException(status_code=404, detail="Experience not found")
    db.delete(exp)
    db.commit()
