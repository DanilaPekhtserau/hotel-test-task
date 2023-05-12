# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :requests, [RequestType], null: false do
      argument :places, Integer, required: false
      argument :order_by, String, required: false
      argument :sorting_direction, String, required: false
    end

    def requests(places: nil, order_by: nil, sorting_direction: '')
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'User does not exist' unless !user.nil? && User.exists?(user.id)

      requests = Pundit.policy_scope(user, Request)
      requests = requests.where(places:) if places.present?
      requests = requests.order(order_by + " #{sorting_direction}") if order_by.present?

      requests
    end

    field :bills, [BillType], null: false do
      argument :client_id, ID, required: false
      argument :order_by, String, required: false
      argument :sorting_direction, String, required: false
    end

    def bills(client_id: nil, order_by: nil, sorting_direction: '')
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'User does not exist' unless !user.nil? && User.exists?(user.id)

      bills = Pundit.policy_scope(user, Bill)
      bills = bills.where(user_id: client_id) if client_id.present?
      bills = bills.order(order_by + " #{sorting_direction}") if order_by.present?

      bills
    end
  end
end
