Feature: Assignment approved/disapproved column 
  As a teacher
  I want to see one more column on the page practical work
  To know the total amount approved and how many students are disapproved.  


  Background:
    Given the course with teacher and student enrolled
    And there is a bunch of assignment already created

  Scenario: assignment without solutions submitted
    Given I am logged in as teacher 
    When  I follow "Trabajos prácticos"
    Then  I should see "0" for "TP1" at column Aprobados in table
    And   I should see "1" for "TP1" at column Desaprobados in table

  Scenario: assignment solutions submitted and disapproved
    Given there are solutions submitted by students
    And  I am logged in as teacher 
    And  I follow "Trabajos prácticos"
    And  I follow "Correcciones" for "TP1"
    And  I follow "Ver soluciones"
    And  I click "Corregir"
    And  I fill in "Comentarios públicos" with "Comentario"
    And  I qualify the solution with "2.0"
    And  I click "Guardar"
    When I follow "Trabajos prácticos"
    Then I should see "0" for "TP1" at column Aprobados in table
    And  I should see "1" for "TP1" at column Desaprobados in table

  Scenario: assignment solutions submitted and approved
    Given there are solutions submitted by students
    And  I am logged in as teacher 
    And  I follow "Trabajos prácticos"
    And  I follow "Correcciones" for "TP1"
    And  I follow "Ver soluciones"
    And  I click "Corregir"
    And  I fill in "Comentarios públicos" with "Comentario"
    And  I qualify the solution
    And  I click "Guardar"
    When I follow "Trabajos prácticos"
    Then I should see "1" for "TP1" at column Aprobados in table
    And  I should see "0" for "TP1" at column Desaprobados in table

  Scenario: assignment solutions submitted and is in progress
    Given there are solutions submitted by students
    And  I am logged in as teacher 
    And  I follow "Trabajos prácticos"
    And  I follow "Correcciones" for "TP1"
    And  I click "Asignar a otro"
    And  I click "Asignar a otro"
    And  I click "Guardar"
    When I follow "Trabajos prácticos"
    Then I should see "0?" for "TP1" at column Aprobados in table
    And  I should see "0?" for "TP1" at column Desaprobados in table