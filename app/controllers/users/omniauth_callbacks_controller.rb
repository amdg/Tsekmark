class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def linkedin
    oauth_response = request.env["omniauth.auth"]
    unless user_signed_in?
      user = User.find_for_linkedin_oauth(oauth_response)
      if user.persisted?
        set_flash_message(:notice, :success, :kind => "LinkedIn") if is_navigational_format?
        sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
      end
    else
      if user_context?
        current_user.create_authentication(oauth_response)
      else
        Authentication.create_with_oauth(oauth_response, current_user, context)
      end
      redirect_to edit_blaster_path
    end
  end

  def facebook
    oauth_response = request.env["omniauth.auth"]
    unless user_signed_in?
      user = User.find_for_facebook_oauth(oauth_response)
      if user.persisted?
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
      else
        session["devise.facebook_data"] = oauth_response
        redirect_to new_user_registration_url
      end
    else
      if user_context?
        current_user.create_authentication(oauth_response)
      else
        Authentication.create_with_oauth(oauth_response, current_user, context)
      end
      redirect_to edit_blaster_path
    end

  end

  def twitter
    oauth_response = request.env["omniauth.auth"]
    unless user_signed_in?
      user = User.find_for_twitter_oauth(oauth_response)
      if user.persisted?
        set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
        sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
      else
        session["devise.twitter_data"] = oauth_response
        redirect_to new_user_registration_url
      end
    else
      if user_context?
        current_user.create_authentication(oauth_response)
      else
        Authentication.create_with_oauth(oauth_response, current_user, context)
      end
      redirect_to edit_blaster_path
    end

  end
end