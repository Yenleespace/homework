require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.find_by_title(title)
    playing = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT 
        *
      FROM
        plays
      WHERE
        title = ?
    SQL
    return nil unless play.length > 0

    Play.new(play.first) # *********** ??? *****
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    raise "#{name} not fount in DB" unless playwright

    # playwright.id ==> playwright_id
    plays = Play.instance.execute(<<-SQL, playwright_id) 
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL

    plays.map { |play| Play.new(play) }
  end

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays") # only one instance bc included Singleton module. execute:is going to take in a string.
    
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id # if @id already exist
  end

  def update
    raise "#{self} not in database" unless self.id # @id doesn't exist in the database before we try and update it. 
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays 
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  
  
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| PlayDBConnection.new(datum) }
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        plays
      WHERE
        name = ?
    SQL
    return nil unless person.length > 0

    Playwright.new(person.first) # ***** ?? ********
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
  end

  # def new
  # end

  def create
  end

  def update
  end

  def get_plays
  end
end
