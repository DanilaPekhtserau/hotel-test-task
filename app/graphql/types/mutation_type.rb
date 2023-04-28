module Types
  class MutationType < Types::BaseObject
    field :create_request, mutation: Mutations::CreateRequest
  end
end
