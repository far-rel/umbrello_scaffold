require 'umbrello_scaffold'
require 'rails'

module UmbrelloScaffold
  class Railtie < Rails::Railtie
    railtie_name :umbrello_scaffold

    rake_tasks do
      load "tasks/umbrello.rake"
    end
  end
end