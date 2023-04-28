class Mutations::CreateRequest < Mutations::BaseMutation
  argument :places, Integer, required: true
  argument :room_class, String, required: true
  argument :time_of_stay, Integer, required: true
  argument :user_id, ID, required: true

  field :request, Types::RequestType, null: false
  field :errors, [String], null: false

  def resolve(user_id:, places:, room_class:, time_of_stay:)
    request = Request.new(user: User.find(user_id), places: places, room_class: room_class, time_of_stay: time_of_stay)
    if request.save
      {
        request: request,
        errors: []
      }
    else
      {
        request: nil,
        errors: request.errors.full_messages
      }
    end
  end
end
