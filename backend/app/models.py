from sqlalchemy import Column, Integer, String, Text
from app.database import Base


class Profile(Base):
    __tablename__ = "profiles"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    title = Column(String(200))
    bio = Column(Text)
    email = Column(String(200))
    github = Column(String(200))
    linkedin = Column(String(200))
    avatar_url = Column(String(500))


class Project(Base):
    __tablename__ = "projects"
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(200), nullable=False)
    description = Column(Text)
    tech_stack = Column(String(500))
    github_url = Column(String(500))
    demo_url = Column(String(500))
    image_url = Column(String(500))


class Skill(Base):
    __tablename__ = "skills"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    category = Column(String(100))
    level = Column(Integer, default=50)


class Experience(Base):
    __tablename__ = "experiences"
    id = Column(Integer, primary_key=True, index=True)
    role = Column(String(200), nullable=False)
    company = Column(String(200), nullable=False)
    period = Column(String(100))
    description = Column(Text)
