class Mutations::CreateBill < Mutations::BaseMutation
  argument :room_id, ID, required: true
  argument :request_id, ID, required: true

  field :bill, Types::BillType, null: false
  field :errors, [String], null: false

  def resolve(room_id:, request_id:)
    user = context[:current_user]
    if user.admin
      bill = Bill.new(user: Request.find(request_id).user, room: Room.find(room_id), cost: Bill.get_cost(room_id, request_id))
      if bill.save
        {
          bill: bill,
          errors: []
        }
      else
        {
          bill: nil,
          errors: bill.errors.full_messages
        }
      end
    end
  end
end
