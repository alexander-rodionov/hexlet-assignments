# frozen_string_literal: true

namespace :hexlet do
  desc 'Upload users from csv'
  task :import_users, [:filename] => :environment do |_t, params|
    file_name = params[:filename]
    data = File.readlines(file_name)
    header = data[0].strip.split(',')
    data[1..].each do |l|
      vals = l.strip.split(',')
      row = header.zip(vals).to_h
      row['birthday'] = Date.strptime(row['birthday'], '%m/%d/%Y')
      User.create(row)
    end
  end
end
