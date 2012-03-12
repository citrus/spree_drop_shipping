class Spree::AbilityDecorator

  include CanCan::Ability

  def initialize(user)
    can :read, Spree::DropShipOrder do |order|
      order.user && order.user == user
    end
    can :update, Spree::DropShipOrder do |order|
      order.user && order.user == user
    end
  end
end

Spree::Ability.register_ability(Spree::AbilityDecorator)
