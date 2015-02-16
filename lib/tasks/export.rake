namespace :export do

  desc "exports newsletter subscriber"
  task newsletter: :environment do
    puts User.where(receive_newsletter: true).map(&:email).join("\n")
  end

end
