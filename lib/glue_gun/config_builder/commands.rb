module GlueGun
  class ConfigBuilder
    module Commands
    end
  end
end

Dir[File.expand_path("../commands/*.rb", __FILE__)].each { |f| puts f; require f }
