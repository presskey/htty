require 'htty'

# Encapsulates the _history_ command.
class HTTY::CLI::Commands::History < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _history_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the help text for the _history_ command.
  def self.help
    'Displays previous request-response activity in this session'
  end

  # Returns the extended help text for the _history_ command.
  def self.help_extended
    'Displays previous request-response activity in this session. Does not '  +
    "communicate with the host.\n"                                            +
    "\n"                                                                      +
    'Only a summary of each request-response pair is shown; the contents of ' +
    'headers and bodies are hidden.'
  end

  # Returns related command classes for the _history_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HistoryVerbose, HTTY::CLI::Commands::Reuse]
  end

  # Performs the _history_ command.
  def perform
    requests = session.requests
    number_width = Math.log10(requests.length).to_i + 1
    index = 1
    requests.each do |request|
      next unless request.response

      number = index.to_s.rjust(number_width)
      index += 1
      print "#{strong number} "
      show_request request

      print((' ' * number_width), ' ')
      show_response request.response
    end
  end

end
