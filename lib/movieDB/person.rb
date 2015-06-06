require 'rubygems'
require 'time'
# Create an actor instance and return the values for the actor variable.
#
#    actor = MovieDB::Actor.instance_eval{create_with_info("Brittany Murphy", "F", "1977-11-10", "2009-12-20")}
#    actor = MovieDB::Actor.instance_eval{create_with_info("George Clooney", "M", "1961-05-06", nil)}

#  Example to find the actor name:
#
#    actor_name = actor.map(&:name) #=> ["Brittany Murphy"]
#
#  Example to see if an actoyre is alive:
#    actor_name = actor.map(&:alive?) #=> [false, true]
#
#   Example to find an actor's age:
#     actor_name = actor.map(&:age) #=> [32, 52]
module MovieDB
  class Person
    attr_accessor :name, :gender, :birth_date, :death_date, :birthplace

    def initialize(name = nil, gender = nil, birth_date = nil, death_date = nil, birth_place = nil, opt={})
      @name = name
      @gender = gender
      @birth_date = birth_date
      @death_date = death_date
      @birth_place = birth_place
    end

    def age
      if alive?
        a = Time.now - Time.parse(@birth_date)
      else
        a = Time.parse(@death_date) - Time.parse(@birth_date)
      end

      return (a/60/60/24/365).to_i
    end

    def alive?
      !@death_date.nil?
    end

    class << self
      def create_with_info(name, gender, birth_date, death_date)
        @person_DS ||= []
        person = MovieDB::Person.new
        person.name = name
        person.gender = gender
        person.birth_date = birth_date
        person.death_date = death_date

        return @person_DS << person
      end

      def filter_person(attr)
       attr = attr.to_sym
       raise ArgumentError "#{attr} can only be name or age" if !attr == :age && :name

       return @person_DS.select{|s| s.alive?}.map(&attr)
      end

      # Returns a random parameter integer between min to max,
      # rather than a float between min to max.(Ruby 2.0.0)
      def sample_attr(attr)
        randgen = Object.new
        attr_array = self.instance_eval{filter_person(attr)}
        attr_array.sample(random: randgen)
      end
    end

    private_class_method :create_with_info, :filter_person

  end

  class Actor < Person
    attr_accessor :filmography

    def initialize(filmography = [])
      super()
      @filmography = filmography
    end

    def addFilms film
      @filmology ||= []
    end

    def actor_actress_gender(person)
      case
      when person.gender == 'F'
        return "actress"
      when person.gender == "M"
        return "actor"
      else
        "N/A"
      end
    end

    class << self
      def filter_actor_alive(attr)
       attr = attr.to_sym
       raise ArgumentError "#{attr} can only be name or age" if !attr == :age && :name

       return @person_DS.select{|s| s.alive?}.map(&"#{attr.to_sym}")
      end

      def filter_actor_deceased(actor)
       return @person_DS.select{ |s| !s.alive?}.map{ |m| "#{m.age}" } if attr == "age"
       return @person_DS.select{ |s| !s.alive?}.map{ |m| "#{m.name}" } if attr == "name"
      end

    end
  end

  class Writer < Person
    attr_accessor :published_work
    alias :published? :published_work

    def initialize(published_work = [])
      super()
      @published_work = published_work
    end

  end

  class Director < Person
    attr_accessor :filmography

    def initialize(filmography = [])
      super()
      @filmography = filmography
    end

  end
end
