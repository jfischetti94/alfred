require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + "/../../models/performance_calculator")

describe PerformanceCalculator do

  let(:calculator)  { PerformanceCalculator.new }
  let(:course)      { Factories::Course.algorithm }
  let(:student)     { Factories::Account.student }
  let(:teacher)     { Factories::Account.teacher }

  let(:assignment1) { Factories::Assignment.name("primer_tp", course) }
  let(:assignment2) { Factories::Assignment.name("segundo_tp", course) }

  def solution1_assignment1
    solution = Alfred::Admin::Solution.new
    solution.link = "www.google.com.ar"
    creation_date = DateTime.new((Date.today.year.to_i - 2), Date.today.month, Date.today.day)
    solution.created_at = creation_date
    solution.account = student
    solution.assignment = assignment1

    solution.save
    solution
  end

  def solution2_assignment1
    solution = Alfred::Admin::Solution.new
    solution.link = "www.taringa.com.ar"
    solution.created_at = DateTime.now
    solution.account = student
    solution.assignment = assignment1

    solution.save
    solution
  end

  def solution3_assignment2
    solution = Alfred::Admin::Solution.new
    solution.link = "www.maps.com.ar"
    solution.created_at = DateTime.now
    solution.account = student
    solution.assignment = assignment2

    solution.save
    solution
  end

  def correction_solution1(solution, grade)
    Alfred::App::Correction.create( :created_at => Date.today, :grade => grade, :teacher => teacher, :solution => solution )
  end

  def correction_solution2(solution, grade)
    Alfred::App::Correction.create( :created_at => Date.today, :grade => grade, :teacher => teacher, :solution => solution )
  end

  def correction_solution3(solution, grade)
    Alfred::App::Correction.create( :created_at => Date.today, :grade => grade, :teacher => teacher, :solution => solution )
  end

  def student_has_corrections_with(grade1, grade2, grade3)
    solution1 = solution1_assignment1
    solution2 = solution2_assignment1
    solution3 = solution3_assignment2
    correction_solution1(solution1, grade1)
    correction_solution1(solution2, grade2)
    correction_solution1(solution3, grade3)
  end

  context 'When I want to know the performance of a student' do

    it 'When a student approves all works with 9 or more then the performance is "Excelente"' do
      student_has_corrections_with(9, 9, 10)
      expect( calculator.performance_for(student, course) ).to eq "Excelente"
    end

    it 'When a student approves all works with 7 or more to 9 then the performance is "Buena"' do
      student_has_corrections_with(7, 8, 6)
      expect( calculator.performance_for(student, course) ).to eq "Buena"
    end

    it 'When a student works average is lower than 7 to 5 then the performance is "Pobre"' do
      student_has_corrections_with(6, 6, 5)
      expect( calculator.performance_for(student, course) ).to eq "Pobre"
    end

    it 'When a student works average is lower than 5 then the performance is "Desastre"' do
      student_has_corrections_with(4, 2, 3)
      expect( calculator.performance_for(student, course) ).to eq "Desastre"
    end

  end

  context 'When I want to obtain the average of a student' do

    it 'should complete the grades list with two 0' do
      list = [4,5,7]

      list_complete = calculator.complete_grade_list(list, 2)

      expect(list_complete).to eq [4,5,7,0,0]
    end

    it 'should give me 5 and 3 as average' do
      list = [5,5,5,5,5]
      incomplete_list = [5,5,5]

      average1 = calculator.get_average(list, 5)
      average2 = calculator.get_average(incomplete_list, 5)

      expect(average1).to eq 5
      expect(average2).to eq 3
    end

  end

  context 'When I want the corrections for some solutions' do

    it 'should bring me a correction list [8,0,4] first, and then [8,10,4]' do
      solution1 = solution1_assignment1
      solution2 = solution2_assignment1
      solution3 = solution3_assignment2
      correction_solution1(solution1, 8)
      correction_solution3(solution3, 4)

      corrections = calculator.get_corrections_grades([solution1, solution2, solution3])

      expect(corrections).to eq [8.0, 0, 4.0]

      correction_solution2(solution2, 10)
      corrections = calculator.get_corrections_grades([solution1, solution2, solution3])
      expect(corrections).to eq [8.0, 10.0, 4.0]
    end

  end

  context 'When I want the latest solution' do

    it 'should obtain the solution with older date' do
      solution1 = solution1_assignment1
      solution2 = solution2_assignment1
      solution3 = solution3_assignment2
      solution3.created_at = DateTime.new(Date.today.year.to_i + 10)

      final_solution = calculator.last_solution([solution1, solution2, solution3])

      expect(final_solution.link).to eq "www.maps.com.ar"
    end

    it 'should bring me the latest solution for each assignment' do
      solution1_assignment1
      solution2_assignment1
      solution3_assignment2

      solution_list = calculator.get_last_solution([assignment1, assignment2], student)

      expect(solution_list[0].link).to eq "www.taringa.com.ar"
      expect(solution_list[1].link).to eq "www.maps.com.ar"
    end

  end

end