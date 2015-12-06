class PerformanceCalculator

  def performance_for(student, course)
    # Obtener todos los assignments pertenecientes al curso
    assignments_list = Assignment.find_by_course(course)
    # Obtener LA ULTIMA solucion para cada assignment, si la misma existiese
    solutions_list = get_last_solution(assignments_list)

    # Obtener promedio de soluciones, e indicar el estado segun promedio
  end

  def filter_ids(list)
    id_list = []

    list.each do | elem |
      id_list << elem.id
    end

    id_list
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
    solution = Solution.new
    solution.created_at = DateTime.new(Date.today.year.to_i - 300)

    solutions_list.each do | sol |
      if sol.created_at > solution.created_at
        solution = sol
      end
    end

    solution
  end

end