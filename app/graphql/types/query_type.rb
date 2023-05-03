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
    end

    def requests(places: nil, order_by: nil)
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'User does not exist' unless !user.nil? && User.exists?(user.id)
      raise GraphQL::ExecutionError, 'No access' unless user.admin

      requests = Request.all
      requests = requests.where(places:) if places.present?
      requests = requests.order(order_by) if order_by.present?

      requests
    end

    field :bills, [BillType], null: false do
      argument :client_id, ID, required: false
      argument :order_by, String, required: false
    end

    def bills(client_id: nil, order_by: nil)
      user = context[:current_user]
      bills = Bill.all
      raise GraphQL::ExecutionError, 'User does not exist' unless !user.nil? && User.exists?(user.id)

      if user.admin
        bills = bills.where(user_id: client_id) if client_id.present?
      else
        bills = bills.where(user_id: user.id)
      end
      bills = bills.order(order_by) if order_by.present?

      bills
    end
  end
end
