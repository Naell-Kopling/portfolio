# Leonardo's Portfolio

Modern minimalist portfolio with black & red theme.

## Structure

```
portfolio/
├── backend/    # FastAPI REST API
├── web/        # Static website (HTML/CSS/JS)
└── mobile/     # Flutter mobile app
```

## Quick Start

### Backend
```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python seed.py
uvicorn app.main:app --reload
```
API docs: http://localhost:8000/docs

### Web
Open `web/index.html` in browser, or serve with:
```bash
cd web && python3 -m http.server 3000
```

### Mobile
```bash
cd mobile
flutter pub get
flutter run
```
