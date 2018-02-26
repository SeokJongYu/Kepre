require 'bio'

class ReportPdf < Prawn::Document
    def initialize(analysis, results, seq)
        super(top_margin: 50)
        @analysis = analysis
        @results = results
        @seq = seq
        @fasta = Bio::FastaFormat.new(@seq.content)
        puts @fasta.aaseq
        @par_seq = @fasta.aaseq.to_s
        @fasta_seq = Bio::Sequence.auto(@fasta.aaseq)
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
        @rank = 0
        table_data =[]
        header = ["Seq position","peptide", "length","allele","ranke"]
        table_data << header
        @results.each do |item|
            puts item.seq_id, item.aa, item.allele, item.score
            if @rank == 0
                @allele = item.allele
                @rank = item.score
                @pos = item.seq_id
                @length = 1
            elsif @rank == item.score and @allele == item.allele and @rank != 0
                #store addtional seq
                @length = @length + 1
                @rank = item.score
            elsif (@rank != item.score or @allele != item.allele) and @rank != 0

                puts @pos, @length
                @pep_seq = @par_seq[@pos-1,@length]
                #pep_seq = @fasta_seq.subseq(@pos,@length)
                table_data << [@pos, @pep_seq, @length, @allele, @rank]

                @allele = item.allele
                @rank = item.score
                @pos = item.seq_id
                @length = 1
            end
        end
        table_data
    end

end