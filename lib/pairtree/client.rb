module Pairtree
  class Client 
    attr_reader :root
    attr_reader :prefix
    def initialize path, args = {}
      args[:root] ||= {}

      @prefix = open(File.join(path, 'pairtree_prefix')).read.strip if File.exists? File.join(path, 'pairtree_prefix')
      args[:root][:prefix] ||= @prefix

      @version = nil

      args[:root][:version] ||= @version

      @root = Pairtree::Root.new File.join(path, 'pairtree_root'), args[:root]
    end
  end
end
