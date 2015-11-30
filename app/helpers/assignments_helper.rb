Alfred::App.helpers do

  def errors_for form_field
    @assignment.errors.key?(form_field) && @assignment.errors[form_field].count > 0
  end

  def pass_for assignment
    count = 0
    in_progress = ''
    @students.each do |student|
      status = (student.status_for_assignment assignment).status
      if status == :correction_passed
        count += 1
      end
      if status == :correction_in_progress || status == :correction_pending
        in_progress = '?'
      end
    end
    return "#{count}#{in_progress}"
  end

  def fail_for assignment
    count = 0
    in_progress = ''
    @students.each do |student|
      status = (student.status_for_assignment assignment).status
      if status == :correction_failed || status ==  :solution_pending
        count += 1
      end
      if status == :correction_in_progress || status == :correction_pending
        in_progress = '?'
      end
    end
    return "#{count}#{in_progress}"
  end
end