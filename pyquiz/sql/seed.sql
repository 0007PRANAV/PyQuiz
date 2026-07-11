INSERT INTO topics (name, slug, description) VALUES
('Basics', 'basics', 'Python basics: syntax, variables, types'),
('Control Flow', 'control-flow', 'if, for, while, comprehensions'),
('Functions', 'functions', 'def, args, kwargs, lambda'),
('OOP', 'oop', 'classes, inheritance, polymorphism');

-- Basics (topic_id=1)
INSERT INTO questions (topic_id, text, options, correct_index, difficulty, tags, explanation, hint) VALUES
(1, 'Which keyword is used to define a function in Python?', '["def", "function", "func", "define"]', 0, 'easy', '["basics","functions"]', 'In Python, functions are defined using the def keyword.', 'Think of how you start a function definition.'),
(1, 'What is the output of: print(type(5))?', '["<class ''int''>", "<class ''float''>", "<class ''str''>", "5"]', 0, 'easy', '["basics","types"]', '5 is an integer, so type(5) is <class ''int''>.', 'Recall the type of whole numbers.'),
(1, 'Which symbol is used for single-line comments in Python?', '["#", "//", "/* */", "--"]', 0, 'easy', '["basics","syntax"]', 'Python uses # for single-line comments.', 'Think of shell-style comments.'),
(1, 'What is the result of: 3 + 2 * 2?', '["7", "10", "8", "5"]', 0, 'easy', '["basics","operators"]', 'Multiplication has higher precedence: 2*2=4, then 3+4=7.', 'Apply operator precedence.'),
(1, 'Which data type is immutable?', '["list", "dict", "set", "tuple"]', 3, 'medium', '["basics","types"]', 'Tuples are immutable; lists, dicts, and sets are mutable.', 'Think of which sequence cannot be changed after creation.');

-- Control Flow (2)
INSERT INTO questions (topic_id, text, options, correct_index, difficulty, tags, explanation, hint) VALUES
(2, 'Which statement is used to iterate over a sequence?', '["for", "if", "while", "loop"]', 0, 'easy', '["control-flow","loops"]', 'for loops iterate over sequences.', 'Think of the most common iteration construct.'),
(2, 'What does range(3) produce?', '["0,1,2", "1,2,3", "0,1,2,3", "1,2"]', 0, 'easy', '["control-flow","range"]', 'range(3) yields 0,1,2.', 'Recall that range is exclusive at the upper bound.'),
(2, 'Which is a list comprehension?', '["[x*2 for x in range(3)]", "for x in range(3): x*2", "map(x*2, range(3))", "lambda x: x*2"]', 0, 'medium', '["control-flow","comprehensions"]', 'List comprehensions use [expr for x in iterable].', 'Look for square brackets and for inside.'),
(2, 'What does this print? for i in [1,2]: print(i, end=" ")', '["1 2 ", "1,2", "1
2", "[1, 2]"]', 0, 'easy', '["control-flow","print"]', 'Loop prints 1 then 2 with spaces.', 'Simulate the loop.'),
(2, 'Which keyword exits a loop early?', '["break", "continue", "return", "exit"]', 0, 'easy', '["control-flow","loops"]', 'break terminates the nearest enclosing loop.', 'Think of stopping a loop.');

-- Functions (3)
INSERT INTO questions (topic_id, text, options, correct_index, difficulty, tags, explanation, hint) VALUES
(3, 'How do you define a function with a default argument?', '["def f(x=1):", "def f(x): =1", "def f(default x=1):", "def f(x): default=1"]', 0, 'easy', '["functions","defaults"]', 'Default args are defined as def f(x=1):.', 'Look at the parameter list.'),
(3, 'What is *args used for?', '["Variable positional arguments", "Variable keyword arguments", "Type hints", "Docstrings"]', 0, 'easy', '["functions","args"]', '*args collects extra positional arguments.', 'Recall the difference between *args and **kwargs.'),
(3, 'What does this return? def f(): pass; print(f())', '["None", "0", "()", "Error"]', 0, 'easy', '["functions","return"]', 'Functions without return return None.', 'Think of what pass does.'),
(3, 'Which creates a lambda that doubles x?', '["lambda x: x*2", "lambda x: x+2", "lambda x: x**2", "lambda x: x/2"]', 0, 'easy', '["functions","lambda"]', 'lambda x: x*2 doubles x.', 'Simple arithmetic lambda.'),
(3, 'What is **kwargs?', '["Variable keyword arguments", "Variable positional arguments", "Keyword-only args", "Type hints"]', 0, 'medium', '["functions","args"]', '**kwargs collects extra keyword arguments.', 'Contrast with *args.');

-- OOP (4)
INSERT INTO questions (topic_id, text, options, correct_index, difficulty, tags, explanation, hint) VALUES
(4, 'How do you define a class?', '["class MyClass:", "def MyClass:", "struct MyClass:", "object MyClass:"]', 0, 'easy', '["oop","classes"]', 'Classes are defined with class ClassName:. ', 'Basic syntax.'),
(4, 'What is __init__?', '["Constructor method", "Destructor method", "Static method", "Class method"]', 0, 'easy', '["oop","init"]', '__init__ is the constructor method.', 'Called on object creation.'),
(4, 'How do you inherit from Base?', '["class Child(Base):", "class Child extends Base:", "class Child implements Base:", "class Child: Base"]', 0, 'easy', '["oop","inheritance"]', 'Python uses class Child(Base):.', 'Compare to Java syntax.'),
(4, 'What does self refer to?', '["Instance", "Class", "Module", "Base class"]', 0, 'easy', '["oop","self"]', 'self refers to the instance.', 'First parameter of instance methods.'),
(4, 'Which decorator defines a class method?', '["@classmethod", "@staticmethod", "@property", "@init"]', 0, 'medium', '["oop","decorators"]', '@classmethod defines a class method.', 'Recall method types.');
