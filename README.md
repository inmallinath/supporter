# Supporter Web Application as part of QUIZ 2 at CodeCore

## Quiz 2 Instructions:

Using the wireframe you see below, implement the following:

* Implement the ability to display the form and submit a support request as displayed in the wireframe (30%)

* Implement the ability to edit / delete / list all the support requests in a table  (30%)

* Implement the ability to mark a support request as `done` or `undone`. All support requests should default to `undone` which should be listed first. (10%)

* Implement the ability to search support requests (search is wildcard search by name / email / department and message). The search must be case insensitive. (10%)

* Implement the ability to paginate all support requests (7 requests per page). Make your seed file generates 1000 support requests (Hint: consider using the Faker gem to generate data and Kaminari gem to implement pagination). (10%)

* Get the pagination and search to work together. So if you search for a term that has more than 7 results it should paginate within the search results and the search term should still show in the search box (10%)

### Bonus

* Write a SQL query that returns a sorted list of the departments and the number of support requests per each department (doesn't have to be inside your Rails app). (10%)
* Redo Part1 and Part2 of the quiz with tests. Make sure to have at least two tests per action. (25%)
