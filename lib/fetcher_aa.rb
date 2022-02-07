require 'sqlite3' # an api connector to the database sqlites3
require 'singleton' # ensures that you have one instance of the class
class QuestionsDatabase < SQLite3::Database # handle the connection to the database
    include Singleton
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end