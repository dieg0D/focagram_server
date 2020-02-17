class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, only: :show

  # GET /users/:id
  def show
    @posts = Post.where(user_id: @user.id)
    @comments = Comment.where(user_id: @user.id)
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user_id: @user.id }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    if params[:old_password]
      if @current_user.authenticate(params[:old_password])
        unless @current_user.update!(password_params)
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        else
          render json: @current_user, except: [:password_digest], methods: :avatar_url, status: :ok
        end
      end
    else
      unless @current_user.update(update_params)
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      else
        render json: @current_user, except: [:password_digest], methods: :avatar_url, status: :ok
      end
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "User not found" }, status: :not_found
  end

  def user_params
    params.permit(:avatar, :name, :username, :email, :password, :password_confirmation, :old_password)
  end

  def update_params
    params.permit(:avatar, :name, :username)
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end
end
