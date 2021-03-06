# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Skill.destroy_all
Job.destroy_all
Test.destroy_all
Application.destroy_all

# Generate Skills
Skill.create!([{ name: 'HTML' }])
Skill.create!([{ name: 'CSS' }])
Skill.create!([{ name: 'JavaScript' }])
Skill.create!([{ name: 'Ruby' }])
Skill.create!([{ name: 'Rails' }])
Skill.create!([{ name: 'PHP' }])
Skill.create!([{ name: 'Python' }])
Skill.create!([{ name: 'NodeJS' }])
Skill.create!([{ name: 'Angular' }])
Skill.create!([{ name: 'VueJS' }])
Skill.create!([{ name: 'React' }])
Skill.create!([{ name: 'SQL' }])
Skill.create!([{ name: 'WordPress' }])
puts "Created #{Skill.all.length} skills."

# Generate Jobs


u1 = User.create!(email: 'admin@gmail.com', full_name: 'Kevin Smith', password: 'chicken',
                phone_no:'9999999', website:'www.tinder.com', about:'About Me', admin: true, suburb:'North Sydney',
                state:'nsw', country:'aus', user_type:"jobseeker")

u2 = User.create!(email: 'freddie@gmail.com',full_name: 'Freddie Jackson',password: 'chicken',
                phone_no:'9999999', website:'www.facebook.com', about:'About Me', admin: false, suburb:'CBD',
                state:'nsw', country:'aus', user_type:"jobseeker")

u3 = User.create!(email: 'oliver@gmail.com',full_name: 'Oliver Cook',password: 'chicken',
                phone_no:'9999999', website:'www.crud.com', about:'About Me', admin: true, suburb:'Hornsy',
                state:'nsw', country:'aus', user_type:"employer")

u4 = User.create!(email: 'ram@gmail.com',full_name: 'Ram Singh',password: 'chicken',
                phone_no:'9999999', website:'www.google.com', about:'About Me', admin: false, suburb:'Waterloo',
                state:'NSW', country:'Australia', user_type:"employer")
puts "Created #{User.all.length} users."


j1 = Job.create!(company_name: '1-Stop Connections' , location: 'Sydney', description: 'Working closely with the UI/UX designer and product manager, the Front End Developer role at 1-Stop is an opportunity to be on the front-line of some of the biggest global tech projects in the industry.', salary: 80000, role: "Junior Front End Developer",  applicants: 0, user_id: u3.id )

j2 = Job.create!(company_name: 'Flo2Cash' , location: 'Sydney', description: 'If you are an engineer who is really willing to improve ,wants to make a difference in customer experience and succeed, we would love to talk to you. In our team, you will have the opportunity to', salary: 60000,  role: "Graduate Back End Developer",  applicants: 0, user_id: u3.id)

j3 = Job.create!(company_name: 'UTS' , location: 'Sydney', description: 'This position will lead on the design and implementation of engaging, responsive web applications and websites for the Connected Intelligence Centre, whose mission is to help UTS students and staff gain timely insights from educational data. Your communication skills will also be put to great use, as you engage people from across the university and beyond with these exciting new applications.', salary: 100000,  role: "Creative Developer",  applicants: 0, user_id: u4.id)

j4 = Job.create!(company_name: 'Torch Professional Services	' , location: 'Sydney', description: 'This is a fantastic opportunity for a smart, ambitious .NET Developer to work within a fast paced dynamic culture that encourages creativity and innovation.', salary: 30500,  role: "Senior Front End Developer", applicants: 0, user_id: u4.id)
puts "Created #{Job.all.length} jobs."

a1 = Application.create! user: u1, job: j1
a2 = Application.create! user: u1, job: j2
a3 = Application.create! user: u2, job: j1
a4 = Application.create! user: u3, job: j1
puts "Created #{Application.all.length} applications."

puts "Associations:"
puts "Job #1 has #{Job.first.applications.length} applications (should be 3)"
puts "User #1 has #{User.first.applications.length} applications (should be 2)"
puts "Done."
