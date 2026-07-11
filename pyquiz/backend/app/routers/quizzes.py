from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from ..database import get_db
from ..models import Question
from .. import schemas

router = APIRouter()

@router.post("/quizzes/start")
async def start_quiz(payload: schemas.QuizStart, db: AsyncSession = Depends(get_db)):
    result = await db.execute(
        select(Question)
        .where(Question.topic_id == payload.topic_id)
        .where(Question.difficulty == payload.difficulty)
        .limit(payload.num_questions)
    )
    questions = result.scalars().all()
    if not questions:
        raise HTTPException(status_code=400, detail="No questions found")
    return {"questions": questions}

@router.post("/quiz-attempts/submit")
async def submit_quiz(payload: schemas.QuizSubmit, db: AsyncSession = Depends(get_db)):
    score = 0
    total = len(payload.answers)
    details = []

    for ans in payload.answers:
        q_result = await db.execute(
            select(Question).where(Question.id == ans.question_id)
        )
        q = q_result.scalar_one_or_none()
        is_correct = (q is not None and q.correct_index == ans.answer_index)
        if is_correct:
            score += 1
        details.append({
            "question_id": ans.question_id,
            "user_answer_index": ans.answer_index,
            "is_correct": is_correct
        })

    return {"score": score, "total": total, "details": details}
