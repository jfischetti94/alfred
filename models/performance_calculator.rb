class PerformanceCalculator

  def performance_for(student, course)
    # Get all assignment that belongs to course
    assignments_list = Assignment.find_by_course(course)

    # get LAST SOLUTION for each assignment, if there is any for each
    solutions_list = get_last_solution(assignments_list)

    # Get a list of grades, corresponding to each correction for those solutions. If a correction doesn't exists, then the grade is 0
    corrections_list = get_corrections(solutions_list)

    # Promediar las correcciones, e indicar el estado segun promedio
    total_assignments = assignments_list.size

  end

  def get_last_solution(assignment_list)
    result_list = []

    assignment_list.each do | assig |
      solutions_for_assignment = Solution.all(:assignment => assig)
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

  def get_corrections(solutions_list)
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

end