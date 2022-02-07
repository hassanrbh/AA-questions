PRAGMA foreign_keys = ON;
-- Add a users table to track the fname and lname attribute
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER UNIQUE PRIMARY KEY NOT NULL,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL
);
-- Add a questions table to track the title and the body and the associated author (a foreign key)
CREATE TABLE IF NOT EXISTS questions (
    question_id INTEGER PRIMARY KEY NOT NULL,
    title VARCHAR(100) UNIQUE NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(user_id)
);
-- Add Questions follow tables and should support the many to many relationship between (questions and users)
CREATE TABLE IF NOT EXISTS question_follows (
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
    FOREIGN KEY (question_id) REFERENCES questions(question_id)

    UNIQUE (user_id, question_id)
);
-- Replies Table for users and questions to reply them and identify them
 CREATE TABLE IF NOT EXISTS replies (
     reply_id INTEGER PRIMARY KEY NOT NULL, -- reply id for recognize the replies
     subject_question VARCHAR(250) NOT NULL, -- the subjects_question points to the title of the question
     reply VARCHAR(250) NOT NULL, -- The reply to the questions
     author_of_question VARCHAR(20) NOT NULL, -- author of who make the question
     parent_reply VARCHAR(250) NOT NULL, -- each reply have to reference to the parent reply.
     body_of_reply TEXT NOT NULL, -- The body of the reply
     top_level_reply TEXT, -- TOP LEVEL REPLIES don't have any parent
 
     FOREIGN KEY (parent_reply) REFERENCES replies(reply)
     FOREIGN KEY (subject_question) REFERENCES questions(title)
     FOREIGN KEY (author_of_question) REFERENCES users(user_id)
);
-- Questions likes TABLE for question of users
CREATE TABLE IF NOT EXISTS question_likes (
    like_id INTEGER PRIMARY KEY NOT NULL, -- The like id
    question_id INTEGER NOT NULL, -- The question that the user likes
    user_id INTEGER NOT NULL,
    likes SMALLINT UNSIGNED INT2 UNSIGNED,

    FOREIGN KEY (question_id) REFERENCES questions(question_id)
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO 
    users (fname,lname)
VALUES 
    ('hassan','tarif'),
    ('aya','binaldin'),
    ('sample','tarif');

-- INSERT INTO 
--     questions (title,body,author_id)
-- VALUES 
--     ('I want to buy something','I love mac',(SELECT user_id FROM users WHERE fname="hassan" )),
--     ('I want to report something messing','report',(SELECT user_id FROM users WHERE fname="aya")),
--     ('I am hacker, and I need money','hacker',(SELECT user_id FROM users WHERE fname="sample"));

-- INSERT INTO 
--     question_follows (user_id,question_id)
-- VALUES 
--     ( (SELECT user_id FROM users WHERE fname="hassan"), (SELECT question_id FROM questions WHERE title="I want to buy something") ),
--     ( (SELECT user_id FROM users WHERE fname="aya"), (SELECT question_id FROM questions WHERE title="I want to report something messing") ),
--     ( (SELECT user_id FROM users WHERE fname="sample"), (SELECT question_id FROM questions WHERE title="I am hacker, and I need money") );
    
    