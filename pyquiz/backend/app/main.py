from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .database import engine, Base
from .routers import topics, quizzes, analytics, study_plans

app = FastAPI(title="PyQuiz API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
async def create_tables():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

app.include_router(topics.router, prefix="/api", tags=["topics"])
app.include_router(quizzes.router, prefix="/api", tags=["quizzes"])
app.include_router(analytics.router, prefix="/api", tags=["analytics"])
app.include_router(study_plans.router, prefix="/api", tags=["study_plans"])

@app.get("/")
def root():
    return {"message": "PyQuiz API"}
