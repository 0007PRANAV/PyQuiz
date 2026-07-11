from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from ..database import get_db
from ..models import Topic, Question
from .. import schemas

router = APIRouter()

@router.get("/topics", response_model=List[schemas.TopicOut])
async def list_topics(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Topic))
    topics = result.scalars().all()
    return topics

@router.get("/topics/{topic_id}/questions")
async def get_questions(topic_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(
        select(Question).where(Question.topic_id == topic_id)
    )
    questions = result.scalars().all()
    return questions
