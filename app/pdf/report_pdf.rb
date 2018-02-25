class ReportPdf < Prawn::Document
    def initialize(analysis, results, seq)
        super(top_margin: 50)
        @analysis = analysis
        @results = results
        @seq = seq
        print_cover
        seq_info
        top_peptide
    end


    def print_cover
        move_down 120
        formatted_text_box(
          [{ text: "MHC I binding prediction report\n", styles: [:bold], size: 30, :align => :center }], at: [20, cursor - 50]
        )
        move_down 10

    end

    def seq_info
        start_new_page
        stroke_horizontal_rule
        pad(13) { text "Sequence information" , size: 16}
        stroke_horizontal_rule
        move_down 20
        text @seq.content, size: 10

    end

    def top_peptide
        move_down 40
        stroke_horizontal_rule
        pad(13) { text "Epitope candidates information" , size: 16}
        stroke_horizontal_rule
        move_down 20

        table line_item_rows do
            row(0).font_style = :bold
            self.row_colors = ["DDDDDD","FFFFFF"]
        end

    end

    def line_item_rows
        table_data =[]
        header = ["Seq position","amino acid","allele","score"]
        table_data << header
        @results.each do |item|
            table_data << [item.seq_id, item.aa, item.allele, item.score]
        end
        table_data
    end

end