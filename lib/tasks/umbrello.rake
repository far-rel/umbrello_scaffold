namespace :umbrello do
  
  task :model do
    UmbrelloScaffold::Parser.new(ARGV[1]).parse(false, *ARGV[2..(ARGV.size)])
  end
  
  task :scaffold do
    UmbrelloScaffold::Parser.new(ARGV[1]).parse(true, *ARGV[2..(ARGV.size)])
  end
  
end

