Alfred::App.helpers do

  def errors_for form_field
    @assignment.errors.key?(form_field) && @assignment.errors[form_field].count > 0
  end

  def pass_for assignment
    count = 0
    @students.each do |student|
      status = (student.status_for_assignment assignment).status
      if status == :correction_passed
        count += 1
      end
    end
    return count
  end

  def fail_for assignment
    count = 0
    @students.each do |student|
      status = (student.status_for_assignment assignment).status
      if status == :correction_failed
        count += 1
      end
    end
    return count
  end
end