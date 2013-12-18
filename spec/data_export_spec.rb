require 'spec_helper'

describe MovieDB::DataExport do
  describe "#generate" do
    let(:data_export) { MovieDB::DataExport.new}
    let(:generate) { MovieDB::DataExport.generate}
    #de =  MovieDB::DataExport.generate('data_analysis')
    it "hould return a call form inherited" do
      data_export.send(:cod).should == []
    end 

    it "generate" do
     # generate.should ==  []
    end

  end
  
end
