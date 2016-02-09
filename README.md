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

Step 1 : Create the rails app using the below command
`rails new support_app -d postgresql -T`

Step 2 : Add the following gems to the `Gemfile`

```ruby
# data for application
gem "faker", '~> 1.6.1'

group :development do
  # console color print
  gem "awesome_print"
  gem "interactive_editor"
  gem "hirb"

  # pagination
  gem 'kaminari'  
end
```

Step 3: run `bundle install`

Step 4: Create the database using `bin/rake db:create`

Step 5: Create the controller using `bin/rails g controller agents`

Step 6: Edit config/routes.rb to include the initial route for the application
```ruby
root 'agents#index'
get '/agents' => 'agents#index'
```

Step 7: Import the image and style the header for the app

Step 8: Generate the model for the app

* Model Name: agent
* Data fields : name:string email:string, department:string message:text

and the command used is:

`bin/rails g model agent name:string email:string department:string message:text`

Step 9: To create the database with the table, run the following command

`bin/rake db:migrate`

Step 10: create data using the `Faker` gem as below:
```ruby
1000.times do
  Agent.create       name: Faker::Name.name,
                   email: Faker::Internet.email,
                   department: ["Sales", "Marketing", "Technical"].sample,
                   message: Faker::Lorem.paragraph
end
```
Step 11: Populate the data with the faker gem using the command `bin/rake db:seed`

Step 12: In order to implement the ability to mark a support request as "done" or "undone", add a new column to the table that takes a boolean value with a default of false
```ruby
class AddRequestToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :request, :boolean, default: false
  end
end
```
Step 13: Add the routes for `new`, `create`,

# CREATE and NEW
get '/agents/new' => 'agents#new', as: :new_agent
post '/agents' => 'agents#create', as: :agents

# LIST and SHOW
get '/agents/:id' => 'agents#show', as: :agent
get '/agents' => 'agents#index'
#

# get "/agents/search" => "agents#search", as: :search_agents
# EDIT AND UPDATE
get '/agents/:id/edit' => 'agents#edit', as: :edit_agent
patch '/agents/:id' => 'agents#update'
#
# DELETE
delete '/agents/:id' => 'agents#destroy'

After having defined the routes, the views and controllers were coded to meet the requirements.

BONUS 1:

### SOLUTION

```SQL
SELECT department, COUNT(*) AS support_request_count
FROM agents
GROUP BY department
ORDER BY department 
```
