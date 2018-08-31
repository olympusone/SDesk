Agent.create!(
   name: 'Agent',
   lastname: 'Demo',
   user: User.new(
       email: 'agent@demo.com',
       password: 'agentedemo',
       confirmed_at: Time.now.to_s(:db)
   )
)