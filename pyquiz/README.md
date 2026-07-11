# PyQuiz

A Python quiz web app with:

- FastAPI backend
- React (Vite) frontend
- Supabase (PostgreSQL + Auth)

## Features (MVP)

- View topics and Python MCQs
- Start a quiz by topic and difficulty
- Submit answers and see score + review
- Extensible structure for auth, analytics, and study plans

## Stack

- Backend: Python, FastAPI, SQLAlchemy (async), Supabase Postgres
- Frontend: React (Vite), React Router, Axios
- Database: Supabase PostgreSQL

## Setup overview

1. Create a Supabase project.
2. Run `sql/schema.sql` and `sql/seed.sql` in Supabase SQL Editor.
3. Configure `backend/.env` with your Supabase credentials.
4. Run backend and frontend locally.

See `docs/SETUP.md` for detailed instructions.
