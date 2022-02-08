require 'sqlite3' # an api connector to the database sqlites3
require 'singleton' # ensures that you have one instance of the class
class QuestionsDatabase < SQLite3::Database # handle the connection to the 
    include Singleton
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end
class Users # for the users table 
    def initialize(options)
    end
end
class Questions # for the questions table 
    def initialize(options)
    end
end
class Questions_follows # for the questionsFollows table
    def initialize(options)
    end
end
class Replies # for the replies table
    def initialize(options)
    end
end
class Questions_likes # for the likes table
    def initialize(options)
    end
end
