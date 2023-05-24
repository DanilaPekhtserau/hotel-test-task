# frozen_string_literal: true

class RequestPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise Pundit::NotAuthorizedError, 'Not authorised to get request scope' unless @user.admin?

      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
