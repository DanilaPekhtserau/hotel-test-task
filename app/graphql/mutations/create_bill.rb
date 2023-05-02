class Mutations::CreateBill < Mutations::BaseMutation
  argument :room_id, ID, required: true
  argument :request_id, ID, required: true

  field :bill, Types::BillType, null: false

  def resolve(room_id:, request_id:)
    user = context[:current_user]
    if !user.nil? and User.exists?(user.id)
      if user.admin
        bill = Bill.new(user: Request.find(request_id).user, room: Room.find(room_id), cost: Bill.get_cost(room_id, request_id))
        if bill.save
          {
            bill: bill
          }
        end
      else
        raise GraphQL::ExecutionError, "No access"
      end
    else
      raise GraphQL::ExecutionError, "User does not exist"
    end
  end
end
