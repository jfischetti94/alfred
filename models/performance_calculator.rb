class PerformanceCalculator

  def performance_for(student, course)
    # Get all assignment that belongs to course
    assignments_list = Assignment.find_by_course(course)

    # get LAST SOLUTION for each assignment, if there is any for each
    solutions_list = get_last_solution(assignments_list, student)

    # Get a list of grades, corresponding to each correction for those solutions. If a correction doesn't exists, then the grade is 0
    grades_list = get_corrections_grades(solutions_list)

    # Obtain the average of the student, and return the status of himself
    student_average = get_average(grades_list, assignments_list.size)
    student_status(student_average)
  end

  def get_last_solution(assignment_list, student)
    result_list = []

    assignment_list.each do | assig |
      solutions_for_assignment = Solution.all(:assignment => assig, :account_id => student.id)
      unless solutions_for_assignment.empty?
        solution = last_solution(solutions_for_assignment)
        result_list << solution
      end
    end

    result_list
  end

  def last_solution(solutions_list)
    solution = solutions_list.first

    solutions_list.each do | sol |
      if sol.created_at > solution.created_at
        solution = sol
      end
    end

    solution
  end

  def get_corrections_grades(solutions_list)
    grade_list = []

    solutions_list.each do | sol |
      correction = Correction.all(:solution => sol).first
      if correction.nil?
        grade_list << 0
      else
        correction.grade.nil? ? grade_list << 0 : grade_list << correction.grade
      end
    end

    grade_list
  end

  def get_average(grade_list, number_of_assignments)
    if grade_list.size < number_of_assignments
      new_grades_list = complete_grade_list(grade_list, (number_of_assignments - grade_list.size))
      (new_grades_list.inject(:+)).to_f / number_of_assignments
    else
      (grade_list.inject(:+)).to_f / number_of_assignments
    end
  end

  def complete_grade_list(list, number_to_add)
    new_list = list

    number_to_add.times do
      new_list << 0
    end

    new_list
  end

  def student_status(average)
    case average
      when 0..4.9 then "Desastre"
      when 5..6.9 then "Pobre"
      when 7..8.9 then "Buena"
      when 9..10  then "Excelente"
      else ""
    end
  end

end