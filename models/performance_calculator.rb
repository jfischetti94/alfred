class PerformanceCalculator

  def performance_for(student, course)
    course_id = course.id
    # Obtener todos los assignments pertenecientes al curso
    assignments_list = Assignment.all(:course_id => course_id)
    assignments_id_list = assignments_list.filter_ids
    # Obtener LA ULTIMA solucion para cada assignment

    ### Si la cantidad de soluciones es menor a la cantidad de assignments, contemplo solo los ultimos dos casos
  end

  def filter_ids(list)
    id_list = []

    list.each do | elem |
      puts elem.id
      id_list << elem.id
    end

    id_list
  end

end