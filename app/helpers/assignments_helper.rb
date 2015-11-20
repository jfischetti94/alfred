Alfred::App.helpers do

  def errors_for form_field
    @assignment.errors.key?(form_field) && @assignment.errors[form_field].count > 0
  end

  def submitted_pass_fail_for assignment
    submitted = assignment.solutions.count
    pass = 0
    fail = 0
    assignment.solutions.each do |solution|
      if not solution.correction.nil?
        if solution.correction.status == :correction_passed
          pass += 1
        end
        if solution.correction.status == :correction_failed
          fail += 1
        end
      end
    end
    return "#{submitted}/#{pass}/#{fail}"
  end

end