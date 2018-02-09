class ToolFactory

    def self.build (item, *args)

        case item
        when "MHC I"
            MhciItem.new(*args)
        when "MHC II"
            MhciiItem.new(*args)
        when "KBIO MHC I"
            KbioMhciItem.new(*args)
        when "KBIO MHC II"
            KbioMhciiItem.new(*args)
        end
    end
end