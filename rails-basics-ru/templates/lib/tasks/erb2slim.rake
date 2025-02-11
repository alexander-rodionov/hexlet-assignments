# frozen_string_literal: true

namespace :views do
  task :convert_to_slim do
    require 'erb2slim'

    dirs = Rails.root.join('app', 'views')
    files = Dir.glob(File.join(dirs, '**', '*html.erb'))

    files.each do |_f|
      slim_file = erb_file.gsub(/\.html\.erb$/, '.html.slim')
      puts "Converting #{erb_file} to #{slim_file}"
      `erb2slim #{erb_file} #{slim_file}`
    end
  end
end
