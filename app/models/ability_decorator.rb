class AbilityDecorator

  include CanCan::Ability

  def initialize(user)
    can :read, DropShipOrder do |order|
      order.user && order.user == user
    end
    can :update, DropShipOrder do |order|
      order.user && order.user == user
    end
  end
end

Ability.register_ability(AbilityDecorator)
