Feature: Students list
  As teacher
  I want to see my students list with pagination
  To define how many students i can see for page

  Scenario: Lower amount of elements to the size of page
    Given the course with teacher and 2 students
      And I am logged in as teacher
    When I follow "Alumnos"
    Then I see 2 elements

@wip
  Scenario: Greater amount of elements to the size of page
    Given the course with teacher and 7 students
      And I am logged in as teacher
    When I follow "Alumnos"
    Then I see 5 elements    
@wip
  Scenario: No elements
    Given the course "2013-1"
      And the teacher "John"
      And I am logged in as teacher
    When I follow "Alumnos"
    Then I see 0 elements