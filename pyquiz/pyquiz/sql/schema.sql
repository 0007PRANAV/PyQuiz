-- profiles
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  avatar_url text,
  bio text,
  total_quizzes int default 0,
  total_questions int default 0,
  avg_score numeric default 0,
  level int default 1,
  created_at timestamptz default now()
);

-- topics
create table topics (
  id serial primary key,
  name text unique not null,
  slug text unique not null,
  description text
);

-- questions
create table questions (
  id serial primary key,
  topic_id int references topics(id) on delete cascade,
  text text not null,
  options jsonb not null,
  correct_index int not null check (correct_index between 0 and 3),
  difficulty text not null check (difficulty in ('easy','medium','hard')),
  tags jsonb,
  explanation text,
  hint text
);

-- quizzes
create table quizzes (
  id serial primary key,
  user_id uuid references auth.users(id) on delete cascade,
  topic_id int references topics(id),
  title text,
  difficulty text,
  num_questions int,
  created_at timestamptz default now()
);

-- quiz_attempts
create table quiz_attempts (
  id serial primary key,
  user_id uuid references auth.users(id) on delete cascade,
  quiz_id int references quizzes(id) on delete cascade,
  started_at timestamptz default now(),
  completed_at timestamptz,
  score int,
  total_questions int,
  time_taken_seconds int
);

-- question_attempts
create table question_attempts (
  id serial primary key,
  quiz_attempt_id int references quiz_attempts(id) on delete cascade,
  question_id int references questions(id),
  user_answer_index int,
  is_correct boolean,
  time_spent_seconds int
);

-- study_plans
create table study_plans (
  id serial primary key,
  user_id uuid references auth.users(id) on delete cascade,
  created_at timestamptz default now(),
  plan_json jsonb,
  status text default 'active' check (status in ('active','completed','archived'))
);

-- Enable RLS
alter table profiles enable row level security;
alter table quizzes enable row level security;
alter table quiz_attempts enable row level security;
alter table question_attempts enable row level security;
alter table study_plans enable row level security;

-- Profiles policies
create policy "Users can read own profile"
  on profiles for select
  using (auth.uid() = id);

create policy "Users can update own profile"
  on profiles for update
  using (auth.uid() = id);

create policy "Users can insert own profile"
  on profiles for insert
  with check (auth.uid() = id);

-- Quizzes policies
create policy "Users can read own quizzes"
  on quizzes for select
  using (auth.uid() = user_id);

create policy "Users can insert own quizzes"
  on quizzes for insert
  with check (auth.uid() = user_id);

-- Quiz attempts policies
create policy "Users can read own quiz attempts"
  on quiz_attempts for select
  using (auth.uid() = user_id);

create policy "Users can insert own quiz attempts"
  on quiz_attempts for insert
  with check (auth.uid() = user_id);

create policy "Users can update own quiz attempts"
  on quiz_attempts for update
  using (auth.uid() = user_id);

-- Question attempts policies
create policy "Users can read question attempts via quiz attempt"
  on question_attempts for select
  using (
    exists (
      select 1 from quiz_attempts qa
      where qa.id = question_attempts.quiz_attempt_id
        and qa.user_id = auth.uid()
    )
  );

create policy "Users can insert question attempts via quiz attempt"
  on question_attempts for insert
  with check (
    exists (
      select 1 from quiz_attempts qa
      where qa.id = question_attempts.quiz_attempt_id
        and qa.user_id = auth.uid()
    )
  );

-- Study plans policies
create policy "Users can read own study plans"
  on study_plans for select
  using (auth.uid() = user_id);

create policy "Users can insert own study plans"
  on study_plans for insert
  with check (auth.uid() = user_id);

create policy "Users can update own study plans"
  on study_plans for update
  using (auth.uid() = user_id);

-- Topics & questions: public read for authenticated users
alter table topics enable row level security;
alter table questions enable row level security;

create policy "Topics public read"
  on topics for select
  to authenticated
  using (true);

create policy "Topics insert"
  on topics for insert
  to authenticated
  with check (true);

create policy "Questions public read"
  on questions for select
  to authenticated
  using (true);

create policy "Questions insert"
  on questions for insert
  to authenticated
  with check (true);
