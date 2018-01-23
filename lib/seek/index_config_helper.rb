module IndexConfigHelper
  def configure_index(&block)
    block.call(index_config)
    index_config
  end

  def index_config
    @config ||= IndexConfiguration.new
  end

  def write(doc)
    index_config.write(doc)
  end
end
