# frozen_string_literal: true

module Mutations
  class CreateBill < Mutations::BaseMutation
    argument :room_id, ID, required: true
    argument :request_id, ID, required: true

    field :bill, Types::BillType, null: false

    def resolve(room_id:, request_id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'User does not exist' unless !user.nil? && User.exists?(user.id)

      Pundit.authorize(user, Bill, :create?)

      bill = Bill.new(user: Request.find(request_id).user, room: Room.find(room_id),
                      cost: Bill.get_cost(room_id, request_id))

      return unless bill.save

      {
        bill:
      }
    end
  end
end
