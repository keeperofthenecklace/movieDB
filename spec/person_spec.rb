require 'spec_helper'

describe MovieDB::Person do

   context "#filter_person" do
     it "should return attributes" do
       MovieDB::Person.instance_eval{create_with_info("Brittany Murphy", "F", "1977-11-10", "2009-12-20")}
       MovieDB::Person.instance_eval{create_with_info("George Clooney", "M", "1961-05-06", "")}
      
       MovieDB::Person.instance_eval{filter_person('name')}.should == ['Brittany Murphy', 'George Clooney']
     end
   end

   context "" do
     it "should return a random integer bewreen min to max" do
        age = MovieDB::Person.instance_eval{filter_person('age')}
        moviePerson = MovieDB::Person.instance_eval{sample_attr('age')}

        #moviePerson.should be_in(age)
     end
   end

end
