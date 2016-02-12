NEW.HTML.ERB

<h1>New Support Request</h1>

<%= @support_request.errors.full_messages.join(", ") %>
<%= form_for @support_request do |f| %>
  <div>
    <%= f.label :name %>
    <%= f.text_field :name %>
  </div>
  <div>
    <%= f.label :email %>
    <%= f.email_field :email %>
  </div>
  <div>
    <%= f.label :department %>
    <%= f.radio_button :department, SupportRequest::DEPT_SALES %> Sales
    <%= f.radio_button :department, SupportRequest::DEPT_MARKETING %> Marketing
    <%= f.radio_button :department, SupportRequest::DEPT_TECHNICAL %> Technical
  </div>
  <div>
    <%= f.label :message %>
    <%= f.text_area :message %>
  </div>
  <%= f.submit %>
<% end %>
-----------------
In the Model - initialize the constants and the methods
class SupportRequest < ActiveRecord::Base

  DEPT_SALES     = "Sales"
  DEPT_MARKETING = "Marketing"
  DEPT_TECHNICAL = "Technical"

  after_initialize :set_defaults

  validates :name, presence: true
  validates :email, presence: true

  private

  def set_defaults
    self.done ||= false
    self.department ||= DEPT_SALES
  end

end
-------------------------
In the routes.rb file
patch "/support_requests/:id/mark_done" => "support_requests#mark_done", as: :mark_done_support_request
  resources :support_requests
-------------------------
IN the controller

class SupportRequestsController < ApplicationController
  def new
    @support_request = SupportRequest.new
  end

  def create
    support_request_params = params.require(:support_request)
                                    .permit(:name, :email, :department, :message)
    @support_request = SupportRequest.new(support_request_params)
    if @support_request.save
      flash[:notice] = "Request Saved!"
      redirect_to support_request_path(@support_request)
    else
      flash[:alert] = "Request not saved"
      render :new
    end
  end

  def show
    @support_request = SupportRequest.find params[:id]
  end

  def index
    @support_requests = SupportRequest.order("done ASC")
  end

  def mark_done
    @support_request = SupportRequest.find params[:id]
    @support_request.done = !@support_request.done
    @support_request.save
    redirect_to support_requests_path
  end

end
---------------------------------------
In the index.html.erb file
<h1>All Requests</h1>

<table>
  <tr>
    <td>Name</td>
    <td>Email</td>
    <td>Department</td>
    <td>Message</td>
    <td></td>
  </tr>
  <% @support_requests.each do |req| %>
    <tr>
      <td><%= req.name %></td>
      <td><%= req.email %></td>
      <td><%= req.department %></td>
      <td><%= req.message %></td>
      <td>
        <% if req.done? %>
          <%= button_to "Un-Done", mark_done_support_request_path(req),
                                method: :patch%>
        <% else %>
          <%= button_to "Done", mark_done_support_request_path(req),
                              method: :patch%>
        <% end %>
      </td>
    </tr>

  <% end %>
</table>
