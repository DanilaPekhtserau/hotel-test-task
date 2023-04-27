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
      requests = Request.all

      if places.present?
        requests = requests.where(places: places)
      end

      if order_by.present?
        requests = requests.order(order_by)
      end

      requests
    end

    field :bills, [BillType], null: false do
      argument :client_id, ID, required: false
      argument :order_by, String, required: false
    end

    def bills(client_id: nil, order_by: nil)
      bills = Bill.all

      if client_id.present?
        bills = bills.where(user_id: client_id)
      end

      if order_by.present?
        bills = bills.order(order_by)
      end

      bills
    end

  end
end
