require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + "/../../models/performance_calculator")
#require '../../models/performance_calculator'

describe PerformanceCalculator do

  let(:calculator) { PerformanceCalculator.new }
  let(:course)     { Factories::Course.algorithm }
  let (:student)   { Factories::Account.student }

  let(:assignment1) { Factories::Assignment.name("primer_tp", course) }
  let(:assignment2) { Factories::Assignment.name("segundo_tp", course) }

  def solution1_assignment1
    solution = Alfred::Admin::Solution.new
    solution.link = "www.google.com.ar"
    creation_date = DateTime.new((Date.today.year.to_i - 2), Date.today.month, Date.today.day)
    solution.created_at = creation_date
    solution.account_id = 1
    solution.assignment_id = 1

    solution.save
    solution
  end

  def solution2_assignment1
    solution = Alfred::Admin::Solution.new
    solution.link = "www.taringa.com.ar"
    solution.created_at = DateTime.now
    solution.account_id = 1
    solution.assignment_id = 1

    solution.save
    solution
  end

  def solution3_assignment2
    solution = Alfred::Admin::Solution.new
    solution.link = "www.maps.com.ar"
    solution.created_at = DateTime.now
    solution.account_id = 1
    solution.assignment_id = 2

    solution.save
    solution
  end

  it 'should funcar' do
    solution1_assignment1
    solution2_assignment1
    solution3_assignment2

    solutions = Solution.all(:assignment => assignment1)

    first = solutions[0].created_at
    second = solutions[1].created_at
    puts first < second
  end

=begin
  it 'When a student approves all works with 9 or more then the performance is "Excelente"' do
    studentHasCorrectionsWith(9,9)
    expect( calculator.performance_for(student,course) ).to eq "Excelente"
  end

  it 'When a student approves all works with 7 or more to 9 then the performance is "Buena"' do
    studentHasCorrectionsWith(7,8)
    expect( calculator.performance_for(student,course) ).to eq "Buena"
  end
  it 'When a student works average is lower than 7 to 5 then the performance is "Pobre"' do
    studentHasCorrectionsWith(6,6)
    expect( calculator.performance_for(student,course) ).to eq "Pobre"
  end

  if 'When a student works average is lower than 5 then the performance is "Desastre"' do
    studentHasCorrectionsWith(4,2)
    expect( calculator.performance_for(student,course) ).to eq "Desastre"
  end
=end

  context 'When I want the latest solution' do

    it 'should obtain the solution with older date' do
      solution1 = solution1_assignment1
      solution2 = solution2_assignment1
      solution3 = solution3_assignment2
      solution3.created_at = DateTime.new(Date.today.year.to_i + 10)

      final_solution = calculator.last_solution([solution1, solution2, solution3])

      expect(final_solution.link).to eq "www.maps.com.ar"
    end

    # it 'should bring me the latest solution for each assignment' do
    #   solution1_assignment1
    #   solution2_assignment1
    #   solution3_assignment2
    #
    #   solution_list = calculator.get_last_solution([assignment1, assignment2])
    #
    #   expect(solution_list[0].link).to eq "www.taringa.com.ar"
    #   expect(solution_list[1].link).to eq "www.maps.com.ar"
    # end

  end





















end