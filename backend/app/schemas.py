from pydantic import BaseModel


class ProfileBase(BaseModel):
    name: str
    title: str | None = None
    bio: str | None = None
    email: str | None = None
    github: str | None = None
    linkedin: str | None = None
    avatar_url: str | None = None
    instagram: str | None = None

class ProfileResponse(ProfileBase):
    id: int
    model_config = {"from_attributes": True}


class ProjectBase(BaseModel):
    title: str
    description: str | None = None
    tech_stack: str | None = None
    github_url: str | None = None
    demo_url: str | None = None
    image_url: str | None = None

class ProjectResponse(ProjectBase):
    id: int
    model_config = {"from_attributes": True}


class SkillBase(BaseModel):
    name: str
    category: str | None = None
    level: int = 50

class SkillResponse(SkillBase):
    id: int
    model_config = {"from_attributes": True}


class ExperienceBase(BaseModel):
    role: str
    company: str
    period: str | None = None
    description: str | None = None

class ExperienceResponse(ExperienceBase):
    id: int
    model_config = {"from_attributes": True}
