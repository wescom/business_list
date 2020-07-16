# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    if user.admin_role?
      can :manage, :all
    end
    if user.supervisor_role?
      can :manage, Business
      can :manage, BusinessType
      can :manage, BusinessSubtype
      can :manage, ServiceType
      can :manage, Contact
      can :manage, Award
      can :manage, Zone
    end
    if user.sales_role?
      can :manage, Business
      can [:read, :business_subtype_options], BusinessType
      can :read, ServiceType
      can :manage, Contact
      can :manage, Award
    end
    if user.user_role?
      can :create, Business
      can :create_business_wizard, Business
      can :read, Business, owner_id: user.id # can manage their own business
      can :update, Business, owner_id: user.id # can manage their own business
      can :delete, Business, owner_id: user.id # can manage their own business
    end
  end
end
