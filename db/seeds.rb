# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
TimeRecord.destroy_all

t_records = TimeRecord.create( [ 
    { id: 1, start_date: DateTime.now, time_type: "bug", comment: "task have bug" },
    { id: 2, start_date: DateTime.now, end_date: DateTime.now + 5.hours, time_type: "issue", comment: "task have another issue" },
    { id: 3, start_date: DateTime.now - 1.days, time_type: "issue", comment: "task have issue" },
    { id: 4, start_date: DateTime.now- 2.days, end_date: DateTime.now + 1.hours, time_type: "feature", comment: "task have feature" },
    { id: 5, start_date: DateTime.now - 4.hours, end_date: DateTime.now + 2.hours, time_type: "done", comment: "task #123 done" },
    { id: 6, start_date: DateTime.now- 11.hours, end_date: DateTime.now + 3.hours, time_type: "done", comment: "task #345 done" },
    { id: 7, start_date: DateTime.now - 4.hours, end_date: DateTime.now + 4.hours, time_type: "bug", comment: "task #451 have bug" },
    { id: 8, start_date: DateTime.now - 12.hours, end_date: DateTime.now + 2.hours, time_type: "feature", comment: "task #321 have new feature" },

])

p "Created #{t_records.count} Time Records"


users = User.create([{
    username: "Joe",
    email: "joe@gmail.com",
    password: "123456",
    is_admin: false,
    time_records: t_records[0..2] 
},
{
    username: "Doe",
    email: "doe@gmail.com",
    password: "123456",
    is_admin: false,
    time_records: t_records[3..4] 
},
{
    username: "can",
    email: "can@gmail.com",
    password: "123456",
    is_admin: false,
    time_records: t_records[5..8] 
},
{

    username: "admin",
    email: "admin@gmail.com",
    password: "123456",
    is_admin: true,
}
])



p "Created #{User.count} Users"
p "Login as a admin email: admin@gmail.com , password: 123456"
p "Login as a user email: can@gmail.com , password: 123456"