require 'fileutils'

namespace :fixtures do
  desc "Clear all Fixtures"
  task :clear do
    #FileUtils.rm Dir.glob('*.json')
    FileUtils.rm Dir.glob(File.expand_path(Dir.pwd)+'/features/support/fixtures/*.json')
  end
end
