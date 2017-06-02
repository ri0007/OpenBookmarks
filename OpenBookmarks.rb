require 'yaml'

OPTION_REGEX = /^-[acls]$/

def set_safari
  ' -a "Safari"'
end

def set_chrome
  ' -a "Google Chrome"'
end

def set_browser_option(open_argv,option)
  open_argv += set_safari if option == '-s'
  open_argv += set_chrome if option == '-c'
  open_argv
end

def show_help
  exec('echo "bkm [-acls] keys"')
end

def not_found_keys_error
  system('echo "ERROR: Not found keys bookmarks."')
  exit(1)
end

def too_many_options_error
  system('echo "ERROR: Too many options."')
  exit(1)
end

def undefined_option_error
  system('echo "ERROR: Exist undefined option."')
  exit(1)
end

def flatten_hash_from(hash)
  hash.each_with_object({}) do |(key, value), memo|
    next flatten_hash_from(value).each do |k, v|
      memo["#{key}:#{k}".intern] = v
    end if value.is_a? Hash
    memo[key] = value
  end
end

def join_bookmarks_url(bookmarks)
  bookmarks.values.join(' ')
end

show_help if ARGV == []

option = nil
show_keys = []
yaml = YAML.load_file('./Bookmarks.yml')
bookmarks_file_path = File.absolute_path './Bookmarks.yml'
bookmarks = flatten_hash_from(yaml)

ARGV.each do |argument|
  unless argument.to_s.match(/^-.$/).nil?
    undefined_option_error if argument.to_s.match(OPTION_REGEX).nil?
    too_many_options_error unless option.nil?
    option = argument.match(OPTION_REGEX).to_s
    next
  end
  show_keys << argument
end

exec("echo '#{bookmarks_file_path}\n#{yaml.to_yaml}'") if option == '-l'
exec("open #{join_bookmarks_url(bookmarks)}") if option == '-a'

show_bookmarks = []
show_keys.each do |show_key|
  show_bookmarks << (bookmarks.keys.map { |key| bookmarks[key] unless key.to_s.match(/(^|:)#{show_key}(:|$)/).nil? }).compact
end
show_bookmarks.flatten!.uniq!

not_found_keys_error if show_bookmarks == []

open_argv = show_bookmarks.join(' ')
open_argv = set_browser_option(open_argv,option)

exec("open #{open_argv}")
