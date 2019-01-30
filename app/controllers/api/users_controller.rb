class Api::UsersController < ApplicationController

  before_action :authenticate_user

  def index
    @users = User.all
       if current_user
      @contacts = current_user.contacts
      render "index.json.jbuilder"
    else
      render json: []
    end
  
  end

   def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if user.save
      render json: {message: 'User created successfully'}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end

end
