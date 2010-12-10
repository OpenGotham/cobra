class Cobra
  module Campfire
    def self.activate(project_path)
      @project_path = project_path

      if valid_config?
        require 'tinder'

        Cobra::Build.class_eval do
          include Cobra::Campfire
        end

        puts "Loaded Campfire notifier"
      elsif ENV['RACK_ENV'] != 'test'
        puts "Can't load Campfire notifier."
        puts "Please add the following to your project's .git/config:"
        puts "[campfire]"
        puts "\tuser = your@campfire.email"
        puts "\tpass = passw0rd"
        puts "\tsubdomain = whatever"
        puts "\troom = Awesomeness"
        puts "\tssl = false"
      end
    end

    def self.config
      campfire_config = Config.new('campfire', @project_path)
      @config ||= {
        :subdomain => campfire_config.subdomain.to_s,
        :user      => campfire_config.user.to_s,
        :pass      => campfire_config.pass.to_s,
        :room      => campfire_config.room.to_s,
        :ssl       => campfire_config.ssl.to_s.strip == 'true'
      }
    end

    def self.valid_config?
      %w( subdomain user pass room ).all? do |key|
        !config[key.intern].empty?
      end
    end

    def notify
      room.speak "#{short_message}. #{commit.url}"
      room.paste full_message if failed?
      room.leave
    end

  private
    def room
      @room ||= begin
        config = Campfire.config
        campfire = Tinder::Campfire.new(config[:subdomain],
            :username => config[:user],
            :password => config[:pass],
            :ssl => config[:ssl] || false)
        campfire.find_room_by_name(config[:room])
      end
    end

    def short_message
      "Build #{short_sha} of #{project} " +
        (worked? ? "was successful" : "failed") +
        " (#{duration.to_i}s)"
    end

    def full_message
      <<-EOM
Commit Message: #{commit.message}
Commit Date: #{commit.committed_at}
Commit Author: #{commit.author}

#{clean_output}
EOM
    end
  end
end
