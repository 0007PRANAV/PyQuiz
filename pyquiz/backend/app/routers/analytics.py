from fastapi import APIRouter

router = APIRouter()

@router.get("/analytics/overview")
async def analytics_overview():
    return {"total_quizzes": 0, "total_questions": 0, "avg_score": 0.0}

@router.get("/analytics/by-topic")
async def analytics_by_topic():
    return []

@router.get("/analytics/weak-topics")
async def analytics_weak_topics():
    return []
