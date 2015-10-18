namespace :helm do
  desc 'generate app and router'
  task :generate_app => :environment do
    Helm::App.new.generate
  end

  desc 'generate all the view related parts'
  task :generate_view, [:path] => :environment do |t, args|
    Helm::View.new(args[:path]).generate
  end
end
