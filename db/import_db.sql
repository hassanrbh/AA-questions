PRAGMA foreign_keys = ON; -- * turns on the foreign key constraints to ensure data integrity

--! Users :

CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER UNIQUE PRIMARY KEY NOT NULL,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL
);

--? Data Table :

INSERT INTO 
    users (fname,lname)
VALUES 
    ('hassan','tarif'),
    ('aya','atoo'),
    ('salman','requadi');

--! Questions :

CREATE TABLE IF NOT EXISTS questions (
    question_id INTEGER UNIQUE PRIMARY KEY NOT NULL,
    title VARCHAR(100) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(user_id)
);

--? Data Table :
 
INSERT INTO 
    questions (title,body,author_id)
VALUES 
    ('I want to buy something',
    'I love mac',
    (SELECT user_id FROM users WHERE fname="hassan" AND lname="tarif"));

INSERT INTO 
    questions(title,body,author_id)
VALUES 
    ('I want to report that the web page is slow',
    'reporter',
    (SELECT user_id FROM users WHERE fname="aya" AND lname="atoo"));

INSERT INTO 
    questions(title,body,author_id)
VALUES 
    ('I am an ethical hacker and I find a xss bug in your website',
    'hacker',
    (SELECT user_id FROM users WHERE fname="salman" AND lname="requadi"));

--! Questions Follows :

CREATE TABLE IF NOT EXISTS question_follows (
    question_follow_id INTEGER PRIMARY KEY NOT NULL,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
    FOREIGN KEY (question_id) REFERENCES questions(question_id)

);

--? Data Table :

INSERT INTO 
    question_follows(user_id,question_id)
VALUES 
    ((SELECT user_id FROM users WHERE fname="hassan" AND lname="tarif"),
    (SELECT question_id FROM questions WHERE title='I want to buy something')),
    ((SELECT user_id FROM users WHERE fname= "aya" AND lname= "atoo"),
    (SELECT question_id FROM questions WHERE title='I want to report that the web page is slow')),
    ((SELECT user_id FROM users WHERE fname= "salman" AND lname= "requadi"),
    (SELECT question_id FROM questions WHERE title= 'I am an ethical hacker and I find a xss bug in your website'));

--! Replies : 

 CREATE TABLE IF NOT EXISTS replies (
     reply_id INTEGER PRIMARY KEY NOT NULL, -- reply id for recognize the replies
     question_id INTEGER NOT NULL, -- the subjects_question points to the title of the question
     author_id VARCHAR(20) NOT NULL, -- author of who make the question
     parent_reply_id INTEGER, -- each reply have to reference to the parent reply.
     body_of_reply TEXT NOT NULL, -- The body of the reply
 
     FOREIGN KEY (parent_reply_id) REFERENCES replies(reply_id)
     FOREIGN KEY (question_id) REFERENCES questions(question_id)
     FOREIGN KEY (author_id) REFERENCES users(user_id)
);

--? Data Table :

 INSERT INTO 
    replies (question_id,author_id,parent_reply_id,body_of_reply)
VALUES 
    ((SELECT question_id FROM questions WHERE title='I want to buy something'),
    (SELECT user_id FROM users WHERE fname="hassan" AND lname="tarif"),NULL,
    'Ohh thank you for the question what do you need to buy , read from us');

INSERT INTO 
    replies (question_id,author_id,parent_reply_id,body_of_reply)
VALUES 
    ((SELECT question_id FROM questions WHERE title='I want to report that the web page is slow'),
    (SELECT user_id FROM users WHERE fname="aya" AND lname="atoo"),
    (SELECT reply_id FROM replies WHERE body_of_reply='Ohh thank you for the question what do you need to buy , read from us'),
    'Ohh We are sorry about the the slowness of the web page we have some problems in our services in 24 hours will all be done, thank you for the patience');

INSERT INTO 
    replies (question_id,author_id,parent_reply_id,body_of_reply)
VALUES 
    ((SELECT question_id FROM questions WHERE title='I am an ethical hacker and I find a xss bug in your website'),
    (SELECT user_id FROM users WHERE fname="salman" AND lname="requadi"),
    (SELECT reply_id FROM replies WHERE body_of_reply='Ohh We are sorry about the the slowness of the web page we have some problems in our services in 24 hours will all be done, thank you for the patience'),
    'Hey, EH, we need some more information for our to company to work with and closed this bug in a under min, thank you for the repport');

--! Questions Likes : 

CREATE TABLE IF NOT EXISTS question_likes (
    like_id INTEGER PRIMARY KEY NOT NULL, -- The like id
    question_id INTEGER NOT NULL, -- The question that the user likes
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(question_id)
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--? Data Table :

INSERT INTO
    question_likes (user_id,question_id)
VALUES
    ((SELECT user_id FROM users WHERE fname="hassan" AND lname="tarif"),
    (SELECT question_id FROM questions WHERE title='I want to buy something')),
    ((SELECT user_id FROM users WHERE fname= "aya" AND lname= "atoo"),
    (SELECT question_id FROM questions WHERE title='I want to report that the web page is slow')),
    ((SELECT user_id FROM users WHERE fname= "salman" AND lname= "requadi"),
    (SELECT question_id FROM questions WHERE title= 'I am an ethical hacker and I find a xss bug in your website'));
    
    