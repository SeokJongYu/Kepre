
# plotting immunogenecity profile for given sequence 
# Keunwan Park, Kbio

library(ggplot2)

options<-commandArgs(trailingOnly=T)
if(length(options) < 2) stop("Invalid argument number\n\nRscript .r [immunogenecity pred output] [out png file name.png : suffix should be given]\n")
if(!is.na(options[1])) input_dat=options[1]
if(!is.na(options[2])) out_png=options[2]

data <- read.table(input_dat,header=T)
#colnames(data) <- c("seq_id","aa","allele","score")

x_lab=vector()

for(i in c(1:nrow(data)) ){
	idx <- as.integer( as.numeric(data[i,1]) )
	x_lab[ idx ] = paste(data[i,1],data[i,2],sep="")
}

for(i in c(1:nrow(data)) ){
	if(data[i,"score"] <= 0.1){
		#data[i,5] = "High"
		data[i,5] = "red"
	}else if(data[i,"score"] > 0.1  & data[i,"score"] <= 0.5){
		#data[i,5] = "Medium"
		data[i,5] = "orange"
	}else if(data[i,"score"] > 0.5  & data[i,"score"] <= 1){
		#data[i,5] = "Low"
		data[i,5] = "yellow"
	}else{
		#data[i,5] = "Background"
		data[i,5] = "white"
	}
}
colnames(data)[5]="colors"

base_size <- 9

col <- c("red","orange","yellow","white")


p <- ggplot(data, aes(allele,seq_id)) + 
	
	geom_tile(aes(fill=data[,5]),colour="grey50",size=0.1) + 
	scale_fill_identity("Class", labels =c("High","Medium","Low","X"), breaks = col, guide = "legend") +
	theme_grey(base_size = base_size) + 
	labs(x = "", y = "") + 
	scale_y_discrete(expand = c(0, 0),limits=c(min(data[,1]):max(data[,1])),labels=x_lab) +
    scale_x_discrete(expand = c(0, 0)) +
	#theme(panel.background = element_blank()) +
	theme_bw() +
	theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_rect(fill = NA, colour = "black", size = 0.3) )	+
	#theme(legend.position = "none", axis.ticks = element_blank(), axis.text.x = element_text(size = base_size*0.8, angle = 330, hjust = 0, colour = "grey50"))
	theme(axis.ticks = element_blank(), axis.text.x = element_text(size = base_size*0.8, angle = 300, hjust = 0, colour = "grey50"), axis.text.y = element_text(size = base_size*0.7, hjust = 1, colour = "grey50"))


ratio <- (length(x_lab)/200)
hei= as.integer(35*ratio)
#if(hei > 40){ hei = 39}

ggsave( file = out_png, height=hei ,limitsize=FALSE )


