# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

root=Workstream.create( name: 'Root Workstream' )
plymouth=Project.create( name: 'Plymouth Rock', parent: root )
fifth=Project.create( name: '5th Floor', parent: plymouth )
drb=User.create( name: 'drb', pwd: 'drb', isadmin: false)
admin=User.create( name: 'admin', pwd: 'admin', isadmin: true )
goal=Goal.create( name: 'Architect Selected', achieved: false, workstream: plymouth, target: "2015-07-01" )
