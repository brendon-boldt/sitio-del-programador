#/bin/bash

#rake db:migrate:redo VERSION=20150715053302
rails runner 'require("./db/update_content.rb"); UpdateContent.new.change'
