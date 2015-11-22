Feature: Assignment approved/disapproved column
  As a teacher
  I want to see one more column on the page practical work
  To know the total amount approved and how many students are deprecated.  


  Background:
    Given the course with teacher and student enrolled
    And there is a bunch of assignment already created
    #And there is a assignment already created

  Scenario: assignment without solutions submitted
    Given I am logged in as teacher 
    When  I follow "Trabajos prácticos"
    Then I should see "0" for "TP1" in table

