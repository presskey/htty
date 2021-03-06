require 'htty'

# Encapsulates the _fragment-set_ command.
class HTTY::CLI::Commands::FragmentSet < HTTY::CLI::Command

  include HTTY::CLI::UrlEscaping

  # Returns the name of a category under which help for the _fragment-set_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _fragment-set_ command.
  def self.command_line_arguments
    'FRAGMENT'
  end

  # Returns the help text for the _fragment-set_ command.
  def self.help
    "Sets the fragment of the request's address"
  end

  # Returns the extended help text for the _fragment-set_ command.
  def self.help_extended
    'Sets the page fragment used for the request. Does not communicate with ' +
    "the host.\n"                                                             +
    "\n"                                                                      +
    "The page fragment will be URL-encoded if necessary.\n"                   +
    "\n"                                                                      +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _fragment-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::FragmentUnset,
     HTTY::CLI::Commands::Address]
  end

  # Performs the _fragment-set_ command.
  def perform
    add_request_if_new do |request|
      clean_arguments = arguments.collect do |a|
        a.gsub(/^#/, '')
      end
      self.class.notify_if_cookies_cleared request do
        request.fragment_set(*escape_or_warn_of_escape_sequences(clean_arguments))
      end
    end
  end

end
