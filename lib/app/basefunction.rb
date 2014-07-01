module BaseFunction
    extend self
    def base_name(name)
        File.basename(name,'.csv')
    end
end
