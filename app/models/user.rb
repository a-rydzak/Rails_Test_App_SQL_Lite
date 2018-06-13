class User < ActiveRecord::Base
  has_one :address
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates_numericality_of :age, :only_integer => true, :greater_than_or_equal_to => 10, :less_than => 150
  validates :happy, presence: true
  # validates :age, presence: true, numericality: true, inclusion: => 10..100

  # this callback will run before saving on create and update
  before_save :downcase_email
  
  # this callback will run after creating a new user
  after_create :successfully_created
  
  # this callback will run after updating an existing user
  after_update :successfully_updated
  
  # this callback will only run on creating a record to ensure a default age of 0
  # before_validation :default_age, on: [:create]

  def full_name #Custom Class and Instance Methods
    "#{self.first_name} #{self.last_name}"
  end
  
  # creating a custom class method. self refers to the User model
  def self.average_age
      self.sum(:age) / self.count
  end
  
  private
    def downcase_email
      self.email.downcase!
    end
    
    def successfully_created
      puts "Successfully created a new user"
    end
    def successfully_updated
      puts "Successfully updated a existing user"
    end
    
    # def default_age
    #   self.age = 0 unless self.age?
    # end
end

# -------------------------------http://guides.rubyonrails.org/active_record_validations.html#message
#--------------------------------http://guides.rubyonrails.org/v3.0.3/active_record_querying.html
# Other Validations
# :length - validates the length of an attribute's value
# :minimum, :maximum, :in, :is
# :numericality - validates whether an attribute is a numeric value
# :odd, :even, and many others
# :presence - validates that the specified attributes are not empty
# :uniqueness - validates whether the value is unique in the corresponding database table. NOTE: always create a unique index in the database too.
# :confirmation - use this when you have two text fields that should receive exactly the same content; assumes the second field name has "_confirmation" appended
# validates_associated - use this when your model has associations with other models and they also need to be validated
# :acceptance - validate whether a checkbox was checked when a form was submitted (usually for 'terms and conditions')
# also, get familiar with :message and :on
#the :message option lets you specify the message that will be added to the errors collection when validation fails. 
# :on option lets you specify when the validation should happen

#---------------------------List of Callbacks
# Creating an Object
# 	before_validation
# 	after_validation
# 	before_save
# 	around_save
# 	before_create
# 	around_create
# 	after_create
# 	after_save
# 	after_commit
# Updating an Object
# 	before_validation
# 	after_validation
# 	before_save
# 	around_save
# 	before_update
# 	around_update
# 	after_update
# 	after_save
# 	after_commit
# Destroying an Object
# 	before_destroy
# 	around_destroy
# 	after_destroy
# 	after_commit

#---------------------------------------------------------Update a Migratiion Model
# $ rails new my_app
# $ cd my_app
# $ rails generate model User first_name:string last_name:string
# $ rake db:migrate
# $ rails generate migration AddHappyColumnToUsers happy:string
#  rake db:migrate:status

# $ rake db:migrate:up VERSION=20080906120000
# $ rake db:migrate:down VERSION=20080906120000

# rails generate migration RemoveEmailColumnFrom Users email, remove_column :users, :hobby 


#---------------------------------------------------------Update a Migratiion Model
#---------------------------------------Has Many _ Same as has_one
# class Message < ActiveRecord::Base
#   belongs_to :user
# end

# class User < ActiveRecord::Base
#   has_many :messages
# end
#---------------------------------------Has Many Through

# $ rails g model Student first_name:string last_name:string
# $ rails g model Course title:string description:text
# $ rails g model Signup student:references course:references

# class Student < ActiveRecord::Base
#   has_many :signups
#   has_many :courses, through: :signups
# end

# class Signup < ActiveRecord::Base
#   belongs_to :student
#   belongs_to :course
# end

# class Course < ActiveRecord::Base
#   has_many :signups
#   has_many :students, through: :signups
# end

# retrieves all the courses that the first student has signed up for
     # Student.first.courses
# retrieves all the students that have signed up for the second course
      #Course.second.students


#-----------------------Example of custom events_attending with user
# class User < ActiveRecord::Base
#   has_one :account
#   has_many :events
#   has_many :attendees
#   has_many :events_attending, through: :attendees, source: :event
# end
# copy
# Now, we can have get to both events created and events attending from any user.

# user = User.first
# user.events # => Retrieves all the events created by this user.
# user.events_attending #=> Retrieves all the events attending by the user.



#-----------------------------------------------------Query Optimization
# rails new optimize

# rails generate model Team name:string mascot:string stadium:string
# rails generate model Player name:string team:references

# rake db:migrate

# 11 queries (N+1)  Let's say that we want to print the home stadium of 10 random players in our database. In the rails console, we can run something like this.
# players = Player.limit(10).order("RANDOM()")
# players.each do |player|
#   puts player.team.stadium
# end
#---------------------V.S.
# 2 queries
# players = Player.includes(:team).limit(10).order("RANDOM()")
# players.each do |player|
#   puts player.team.stadium
# end


#-----------------------------------------------Joins
# Player.joins(:team).where("teams.name = 'Los Angeles Lakers'") #Instead Of
# Player.includes(:team).where("teams.name = 'Los Angeles Lakers'").references(:team)

#------------------------------------------------Polymorphic

# Polymorphism
#   In Ruby on Rails, Polymorphism is the ability for a single model to 
#   belong to more than one other model. Let's create a new rails 
#   application that will implement the example on the Ruby on Rails guide.