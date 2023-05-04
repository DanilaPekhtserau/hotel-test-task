# frozen_string_literal: true

class BillPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    @user.admin?
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
      if @user.admin?
        scope.all
      else
        scope.where(user_id: @user.id)
      end
    end

    private

    attr_reader :user, :scope
  end
end
