require 'find'
require 'fileutils'
module Pairtree
  class Root
    SHORTY_LENGTH = 2

    attr_reader :root
    def initialize root, args = {}
      @root = root
      
      @shorty_length = args.delete(:shorty_length) || SHORTY_LENGTH
      @prefix = args.delete(:prefix) || ''

      @options = args
    end

    def list          
      objects = []
      return [] unless pairtree_root? @root

      Dir.chdir(@root) do
      Find.find(*Dir.entries('.').reject { |x| x =~ /^\./ }) do |path|
        if File.directory? path
          Find.prune if File.basename(path).length > @shorty_length
	  objects << path if Dir.entries(path).any? { |f| f.length > @shorty_length or File.file? File.join(path, f) }
	  next
      end
	end
      end

      objects.map { |x| @prefix + Pairtree::Path.path_to_id(x) }
    end

    def mk id
      id.sub! @prefix, ''
      path = File.join(@root, Pairtree::Path.id_to_path(id))
      FileUtils.mkdir_p path
      Pairtree::Obj.new path
    end

    def get id
      id.sub! @prefix, ''
      path = File.join(@root, Pairtree::Path.id_to_path(id))
      Pairtree::Obj.new path if File.directory? path
    end

    private

    def pairtree_root
      Dir.new @root
    end

    def pairtree_root? path = @root
      File.directory? path
    end
  end
end
