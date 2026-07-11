from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, DateTime, Numeric, Text
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from .database import Base

class Profile(Base):
    __tablename__ = "profiles"
    id = Column(String, primary_key=True)
    username = Column(String, unique=True)
    avatar_url = Column(String)
    bio = Column(Text)
    total_quizzes = Column(Integer, default=0)
    total_questions = Column(Integer, default=0)
    avg_score = Column(Numeric, default=0)
    level = Column(Integer, default=1)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

class Topic(Base):
    __tablename__ = "topics"
    id = Column(Integer, primary_key=True)
    name = Column(String, unique=True, nullable=False)
    slug = Column(String, unique=True, nullable=False)
    description = Column(Text)
    questions = relationship("Question", back_populates="topic")

class Question(Base):
    __tablename__ = "questions"
    id = Column(Integer, primary_key=True)
    topic_id = Column(Integer, ForeignKey("topics.id"))
    text = Column(Text, nullable=False)
    options = Column(JSONB, nullable=False)
    correct_index = Column(Integer, nullable=False)
    difficulty = Column(String, nullable=False)
    tags = Column(JSONB)
    explanation = Column(Text)
    hint = Column(Text)
    topic = relationship("Topic", back_populates="questions")

class Quiz(Base):
    __tablename__ = "quizzes"
    id = Column(Integer, primary_key=True)
    user_id = Column(String, ForeignKey("profiles.id"))
    topic_id = Column(Integer, ForeignKey("topics.id"))
    title = Column(String)
    difficulty = Column(String)
    num_questions = Column(Integer)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

class QuizAttempt(Base):
    __tablename__ = "quiz_attempts"
    id = Column(Integer, primary_key=True)
    user_id = Column(String, ForeignKey("profiles.id"))
    quiz_id = Column(Integer, ForeignKey("quizzes.id"))
    started_at = Column(DateTime(timezone=True), server_default=func.now())
    completed_at = Column(DateTime(timezone=True))
    score = Column(Integer)
    total_questions = Column(Integer)
    time_taken_seconds = Column(Integer)

class QuestionAttempt(Base):
    __tablename__ = "question_attempts"
    id = Column(Integer, primary_key=True)
    quiz_attempt_id = Column(Integer, ForeignKey("quiz_attempts.id"))
    question_id = Column(Integer, ForeignKey("questions.id"))
    user_answer_index = Column(Integer)
    is_correct = Column(Boolean)
    time_spent_seconds = Column(Integer)

class StudyPlan(Base):
    __tablename__ = "study_plans"
    id = Column(Integer, primary_key=True)
    user_id = Column(String, ForeignKey("profiles.id"))
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    plan_json = Column(JSONB)
    status = Column(String, default="active")
