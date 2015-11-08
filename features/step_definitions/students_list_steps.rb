Given(/^the course with teacher and 2 students$/) do
  step 'the course "2013-1"'
  step 'the teacher "John"'
  step 'the student "Riquelme"'
  step 'the student "Tevez"'
end

Given(/^the course with teacher and 7 students$/) do
  step 'the course "2013-1"'
  step 'the teacher "John"'
  step 'the student "Riquelme"'
  step 'the student "Tevez"'
  step 'the student "Palermo"'
  step 'the student "Schiavi"'
  step 'the student "Abbondanzieri"'
  step 'the student "Calleri"'
  step 'the student "Battaglia"'
end


Given(/^I want to see (\d+) students in the list$/) do | size |
  select(size.to_s, from: 'pagesize')
end

Then(/^I see (\d+) elements$/) do |n|
  page.all('table#studentsGrid tr').count.should == n.to_i+1
end