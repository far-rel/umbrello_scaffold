namespace :umbrello do
  
  task :model do
    UmbrelloScaffold::Parser.new(args[0]).parse(false, args[1..(args.size)])
  end
  
  task :scaffold do
    UmbrelloScaffold::Parser.new(args[0]).parse(true, args[1..(args.size)])
  end
  
end

