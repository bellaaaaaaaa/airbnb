class UsersController < Clearance::UsersController
    private 

    # Override user_from_params from defaul clearance controller
    def user_from_params
        email = user_params.delete(:email)
        password = user_params.delete(:password)
        fullname = user_params.delete(:fullname)
        age = user_params.delete(:age)
    
        Clearance.configuration.user_model.new(user_params).tap do |user|
          user.email = email
          user.password = password
          user.fullname = fullname
          user.age = age
        end
      end
    
end
