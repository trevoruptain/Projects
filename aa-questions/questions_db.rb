require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("questions.db")
    self.type_translation = true
    self.results_as_hash = true
  end

end

class User
  attr_accessor :id, :fname, :lname
  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM users')
    data.map{ |datum| User.new(datum) }
  end

  def self.find_by_id (id)
    name = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL

    return nil if name.length == 0
    User.new(name.first)
  end

  def self.find_by_name(fname, lname)
    name = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND
        lname = ?
      SQL

    return nil if name.length == 0
    User.new(name.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end
end

class Question
  attr_accessor :id, :title, :body, :author_id
  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    data.map{ |datum| Question.new(datum) }
  end

  def self.find_by_id (id)
    name = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
      SQL

    return nil if name.length == 0
    Question.new(name.first)
  end

  def self.find_by_author_id (id)
    author = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        ? = author_id
      SQL

    return nil if author.length == 0
    Question.new(author.first)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
      INSERT INTO
        questions (title, body, author_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, author_id = ?
      WHERE
        id = ?
    SQL
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_parent_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end
end

class Reply
  attr_accessor :id, :body, :parent_id, :user_id, :questions_id
  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    data.map{ |datum| Reply.new(datum) }
  end

  def self.find_by_id (id)
    name = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL

    return nil if name.length == 0
    Reply.new(name.first)
  end

  def self.find_by_parent_id (id)
    name = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        ? = parent_id
      SQL

    return nil if name.length == 0
    Reply.new(name.first)
  end

  def self.find_by_user_id (id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
      SQL

    return nil if user.length == 0
    Reply.new(user.first)
  end

  def self.find_by_question_id (id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
      SQL

    return nil if question.length == 0
    Reply.new(question.first)
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @questions_id = options['questions_id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @body, @parent_id, @user_id, @questions_id)
      INSERT INTO
        replies (body, parent_id, user_id, questions_id)
      VALUES
        (?, ?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @body, @parent_id, @user_id, @questions_id, @id)
      UPDATE
        replies
      SET
        body = ?, parent_id = ?, user_id = ?, questions_id = ?
      WHERE
        id = ?
    SQL
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@questions_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(@id)
  end
end

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM questions_follows')
    data.map{ |datum| QuestionFollow.new(datum) }
  end

  def self.find_by_id (id)
    name = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions_follows
      WHERE
        id = ?
      SQL

    return nil if name.length == 0
    QuestionFollow.new(name.first)
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, fname, lname
      FROM
        users
      JOIN questions
        ON users.id = questions.author_id
      WHERE
        ? = questions.id
    SQL

    return nil if followers.length == 0

    followers.map {|follower| User.new(follower)}
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        users
      JOIN questions
        ON users.id = questions.author_id
      WHERE
        ? = users.id
    SQL

    return nil if questions.length == 0
    questions.map {|question| Question.new(question)}
  end

  def self.most_followed_questions(n)
    most_followed = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN users
        ON users.id = questions.author_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) ASC
      LIMIT
        ?
    SQL

    return nil if most_followed.length == 0
    most_followed.map {|question| Question.new(question)}
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
      INSERT INTO
        questions_follows (user_id, question_id)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @id)
      UPDATE
        questions_follows
      SET
        user_id = ?, question_id = ?
      WHERE
        id = ?
    SQL
  end
end

class QuestionLike

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        user_id
      FROM
        question_likes
      WHERE
        ? = question_id
    SQL

    return nil if likers.length == 0
    likers.map {|id| User.find_by_id(id)}
  end
end
