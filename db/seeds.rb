Agent.create!(
   name: 'Agent',
   lastname: 'Demo',
   user: User.new(
       email: 'agent@demo.com',
       password: 'agentedemo',
       confirmed_at: Time.now.to_s(:db)
   )
)

Admin.create!(
    name: 'Agent',
    lastname: 'Demo',
    user: User.new(
        email: 'admin@demo.com',
        password: 'admindemo',
        confirmed_at: Time.now.to_s(:db)
    )
)