import os
import secrets
from fastapi import Header, HTTPException

def require_admin(x_api_key: str = Header(default="")):
    expected = os.getenv("ADMIN_API_KEY", "")
    if not expected or not secrets.compare_digest(x_api_key, expected):
        raise HTTPException(status_code=401, detail="Unauthorized")
