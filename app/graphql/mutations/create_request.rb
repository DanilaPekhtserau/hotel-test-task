class Mutations::CreateRequest < Mutations::BaseMutation
  argument :places, Integer, required: true
  argument :room_class, String, required: true
  argument :time_of_stay, Integer, required: true

  field :request, Types::RequestType, null: false

  def resolve(places:, room_class:, time_of_stay:)
    user = context[:current_user]
    if !user.nil? and User.exists?(user.id)
      request = Request.new(user: user, places: places, room_class: room_class, time_of_stay: time_of_stay)
      if request.save
        {
          request: request
        }
      end
    else
      raise GraphQL::ExecutionError, "User does not exist"
    end
  end
end
