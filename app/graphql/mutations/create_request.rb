class Mutations::CreateRequest < Mutations::BaseMutation
  argument :places, Integer, required: true
  argument :room_class, String, required: true
  argument :time_of_stay, Integer, required: true

  field :request, Types::RequestType, null: false

  def resolve(places:, room_class:, time_of_stay:)
    user = context[:current_user]
    raise GraphQL::ExecutionError, 'User does not exist' unless !user.nil? and User.exists?(user.id)

    request = Request.new(user:, places:, room_class:, time_of_stay:)
    return unless request.save

    {
      request:
    }
  end
end
