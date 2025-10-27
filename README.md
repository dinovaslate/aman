# Aurora Auth Experience

A polished authentication experience featuring an animated Flutter front-end inspired by contemporary Material You patterns and a Django REST backend for secure token-based authentication.

## Flutter app
- Location: `flutter_app`
- Highlights:
  - Animated gradient background with morphing organic shapes
  - Tabbed login/register forms with rich validation and micro-interactions
  - Shared design system using Material 3, Google Fonts and custom components
  - Widget test validating the tab navigation

### Running the Flutter app
```bash
cd flutter_app
flutter pub get
flutter run -d chrome # or your preferred device
```

### Running Flutter tests
```bash
cd flutter_app
flutter test
```

## Django backend
- Location: `backend`
- Implements `/api/auth/register/`, `/api/auth/login/` and `/api/auth/profile/` endpoints
- Uses token authentication and includes integration tests covering the registration and login flow

### Setup and run
```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

### Run backend tests
```bash
cd backend
python manage.py test
```
