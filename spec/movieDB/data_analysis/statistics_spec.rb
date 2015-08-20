require 'daru'
require 'spec_helper'
require 'MovieDB'

describe MovieDB  do
  describe "Dataframe Statistics" do
    m =  MovieDB::Movie.new
    m.fetch("0369610", "3079380", "0478970")

    context '#mean' do
       it 'should calculate mean of all values' do
         expect(m.mean.round(2)).to eq(Daru::Vector.new([ 2891127.4, 36972648.98, 1445963.96],
                                                         index: ['ant-man', :jurassic_world, :spy]))
       end
    end

    context '#std' do
      it 'should calculate the standard deviation of all values.' do
        # expect(m.std.round(2)).to eq(Daru::Vector.new([19378919.54, 226221711.36, 9689400.78],
        #                                               index: ['ant-man', :jurassic_world, :spy]))
      end
    end

    context '#sum' do
      it 'should calculate the sum of all values' do
        # expect(m.sum.round(2)).to eq(Daru::Vector.new([130100733.0, 1663769204.0, 65068378.0],
        #                                               index: ['ant-man', :jurassic_world, :spy]))
      end
    end

    context '#count' do
      it 'should count all values' do
        # expect(m.count.round(2)).to eq(Daru::Vector.new([45, 45, 45],
        #                                               index: ['ant-man', :jurassic_world, :spy]))
      end
    end

    context '#max' do
      it 'should calculate the max of all values' do
        # expect(m.max.round(2)).to eq(Daru::Vector.new([130000000.0, 1513528810.0, 65000000.0],
        #                                                 index: ['ant-man', :jurassic_world, :spy]))
      end
    end

    context '#describe' do
      it 'should calculate mean, std, max, min and count of all values' do
        # expect(m.describe.round(1)).to eq(Daru::DataFrame.new({
        #                                                       'ant-man':[
        #                                                               45.0,
        #                                                               # 2891127.4,
        #                                                               19378919.5,
        #                                                               0.0,
        #                                                               130000000.0
        #                                                           ],
        #                                                  jurassic_world: [
        #                                                               45.0,
        #                                                               # 36972649.0,
        #                                                               226221711.5,
        #                                                               0.0,
        #                                                               1513528810],
        #                                                             spy: [
        #                                                               45.0,
        #                                                               # 1445964.0,
        #                                                               9689400.8,
        #                                                               0.0,
        #                                                               65000000.0
        #                                                       ]
        #                                                     }, index: [:count, :mean, :std, :min, :max]))
      end
    end

    context '#cov' do
      it 'should calculate variance covariance of the numeric vectors of all values' do
        # expect(m.covariance).to eq(Daru::DataFrame.new({
        #                                                'ant-man': [3755425226, 3338602987, 1877701123],
        #                                           jurassic_world: [3338602987, 5.11762626, 1669151003],
        #                                                      spy: [1877701123, 1669151003, 9388448753]
        #                                                 }, index: ['ant-man', :jurassic_world, :spy]
        #                                               ))
      end
    end

    context "#corr" do
      it "should calculates the correlation between the numeric vectors of all values" do
        # expect(m.correlation).to eq(Daru::DataFrame.new({
        #                                                   'ant-man': [1.0, 0.08, 1.0],
        #                                              jurassic_world: [0.08, 1.0, 0.08],
        #                                                         spy: [1.0, 0.08, 1.0]
        #                                                }, index: ['ant-man', :jurassic_world, :spy]
        #                                              ))
      end
    end

    context "#standardize" do
      it "should standardize all values" do
        # expect(m.standardize only: [:budget, :revenue]).to eq(Daru::DataFrame.new({
        #                                                   'ant-man': [0.70710678, -0.7071067],
        #                                              jurassic_world: [-0.7071067, 0.70710678],
        #                                                         spy: [0.70710678 , -0.7071067 ]
        #                                                 }, index: [:budget, :revenue]))
      end
    end

  end
end