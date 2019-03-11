class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new
    if current_user.admin == true
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    else
      cannot :access, :rails_admin
    end
  end
end
