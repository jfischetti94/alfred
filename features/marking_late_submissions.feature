Feature: Marking late submissions

  Background:
    Given the course with teacher and student enrolled 
    And there is a bunch of assignment already created
    And there are solutions submitted by students


  Scenario: Submitting a solution overdue
    Given A overdue solution for "TP1" submitted by a student
    And I am logged in as teacher
    When I follow "Trabajos prácticos"
    And I follow "Correcciones" for "TP1"
    Then the solution for "TP1" is marked as "*"