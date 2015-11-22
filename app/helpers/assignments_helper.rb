Alfred::App.helpers do

  def errors_for form_field
    @assignment.errors.key?(form_field) && @assignment.errors[form_field].count > 0
  end

  def pass_for assignment
    return 0
  end

  def fail_for assignment
    fails = 0

    assignment.solutions.each do |solution|
      if not solution.correction.nil?
        if solution.correction.status == :correction_failed
          fails += 1
        end
      end
    end
    return fails
  end
end