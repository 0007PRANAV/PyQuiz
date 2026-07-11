from fastapi import APIRouter

router = APIRouter()

@router.post("/study-plans/generate")
async def generate_study_plan():
    return {"plan_json": {"weak_topics": [], "actions": []}, "status": "active"}
