# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
users = User.create([
                      {
                        email: 'myemail@gmail.com',
                        password: 'valid_password',
                        admin: false
                      },
                      {
                        email: 'UwUmail@gmail.com',
                        password: 'Dox72r465de',
                        admin: false
                      },
                      {
                        email: 'mail@mail.com',
                        password: 'c3749ft83cft',
                        admin: true
                      }
                    ])

rooms = Room.create!([
                       {
                         places: 1,
                         room_class: 'normal',
                         price: 10
                       },
                       {
                         places: 2,
                         room_class: 'normal',
                         price: 18
                       },
                       {
                         places: 3,
                         room_class: 'lux',
                         price: 100
                       },
                       {
                         places: 2,
                         room_class: 'business',
                         price: 50
                       }
                     ])

Request.create!([
                  {
                    places: 2,
                    room_class: 'lux',
                    time_of_stay: 7,
                    user: users.first
                  },
                  {
                    places: 1,
                    room_class: 'normal',
                    time_of_stay: 7,
                    user: users[2]
                  }
                ])
Bill.create!([
               {
                 cost: 126,
                 room: rooms[2],
                 user: users.first
               }
             ])
