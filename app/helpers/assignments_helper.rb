Alfred::App.helpers do

  def errors_for form_field
    @assignment.errors.key?(form_field) && @assignment.errors[form_field].count > 0
  end

  def pass_for assignment
    return 0
  end

  def fail_for assignment
    return 0
  end

end