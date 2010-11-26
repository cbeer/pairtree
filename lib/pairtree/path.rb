module Pairtree
  class Path
    def self.id_to_path id
      File.join(Pairtree::Identifier.encode(id).scan(/..?/))
    end

    def self.path_to_id ppath
      Pairtree::Identifier.decode(ppath.split(File::SEPARATOR).join)
    end
  end
end
