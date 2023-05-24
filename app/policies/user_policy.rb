# frozen_string_literal: true

class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    true
  end

  def new?
    create?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise Pundit::NotAuthorizedError, 'Not authorised to get user scope' unless @user.admin?

      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
