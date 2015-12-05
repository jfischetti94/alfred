require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + "/../../models/performance_calculator")
#require '../../models/performance_calculator'

describe PerformanceCalculator do


  let(:calculator) { PerformanceCalculator.new }
  let (:student) { Account.new(:email => "student@test.com", :role => "student", :buid => "?") }
  let (:course) { Course.new(:name => "Curso1", :active => true)}

  def studentHasCorrectionsWith(grade1,grade2)
    assignment1 = Assignment.new(
      :course => course,
      :id => 123,
      :name => 'TP1')
    assignment2 = Assignment.new(
      :course => course,
      :id => 456,
      :name => 'TP2')
    assignment1.save
    assignment2.save
    solution1 = Solution.new(:assignment => assignment1, :account => student)
    solution2 = Solution.new(:assignment => assignment2, :account => student)
    solution1.save
    solution2.save
    correction1 = Correction.new(
      :teacher => Factories::Account.teacher( "Yoda", "yoda@d.com"),
      :solution => solution1,
      :public_comments => "public comment",
      :private_comments => "private comment",
      :grade => grade1
    )
     correction2 = Correction.new(
      :teacher => Factories::Account.teacher( "Yoda", "yoda@d.com"),
      :solution => solution2,
      :public_comments => "public comment",
      :private_comments => "private comment",
      :grade => grade2
    )
    correction1.save
    correction2.save
  end

  it 'When a student approves all works with 9 or more then the performance is "Exelente"' do
    studentHasCorrectionsWith(9,9)
    expect( calculator.performance_for(student,course) ).to eq "Exelente"
  end
=begin
  it 'When a student approves all works with 7 or more to 9 then the performance is "Buena"' do
    studentHasCorrectionsWith(7,8)
    expect( calculator.performance_for(student,course) ).to eq "Exelente"
  end

  it 'When a student works average is lower than 7 to 5 then the performance is "Pobre"' do
    studentHasCorrectionsWith(6,6)
    expect( calculator.performance_for(student,course) ).to eq "Exelente"
  end

  if 'When a student works average is lower than 5 then the performance is "Desastre"' do
    studentHasCorrectionsWith(4,2)
    expect( calculator.performance_for(student,course) ).to eq "Exelente"
  end
=end
end