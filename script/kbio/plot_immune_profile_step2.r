
# plotting immunogenecity profile for given sequence 
# Keunwan Park, Kbio

library(ggplot2)
#library(gridExtra)
#library(RGraphics)
#library(cowplot)

options<-commandArgs(trailingOnly=T)
if(length(options) < 2) stop("Invalid argument number\n\nRscript .r [immunogenecity pred output] [out png file, only prefix!]\n")
if(!is.na(options[1])) input_dat=options[1]
if(!is.na(options[2])) out_png=options[2]

data <- read.table(input_dat,header=T)
#colnames(data) <- c("seq_id","aa","allele","score")

x_lab=vector()
x_idx=vector()

for(i in c(1:nrow(data)) ){
	idx <- as.integer( as.numeric(data[i,1]) )
	x_lab[ idx ] = paste(data[i,1],data[i,2],sep="")
	x_idx[ idx ] = data[i,1]
}
print(x_idx)
score1=as.vector(matrix(0,1,length(x_lab)))
score5=as.vector(matrix(0,1,length(x_lab)))
score10=as.vector(matrix(0,1,length(x_lab)))



for(i in c(1:nrow(data)) ){
	idx <- as.integer( as.numeric(data[i,1]) )
	if(data[i,"score"] < 1){
		score1[idx] = score1[idx] + 1	
	}
	if(data[i,"score"] < 5){
		score5[idx] = score5[idx] + 1	
	}
	if(data[i,"score"] < 10){
		score10[idx] = score10[idx] + 1	
	}
}

score1_class=as.vector(matrix(0,1,length(x_lab)))
score5_class=as.vector(matrix(0,1,length(x_lab)))
score10_class=as.vector(matrix(0,1,length(x_lab)))

## ---- CUT OFF for promiscuous binding -----------
Promiscuity_cut = 0.25	# % 
## ------------------------------------------------

n_allele = length(levels(data[,"allele"]))

for(i in c(1:length(score1))){
	if(score1[i]/n_allele > Promiscuity_cut){
		score1_class[i] = "red"
	}else{
		score1_class[i] = "white"
	}
	if(score5[i]/n_allele > Promiscuity_cut){
		score5_class[i] = "orange"
	}else{
		score5_class[i] = "white"
	}
	if(score10[i]/n_allele > Promiscuity_cut){
		score10_class[i] = "yellow"
	}else{
		score10_class[i] = "white"
	}

}

df1 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score1_class, value = score1, class="score1");
df5 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score5_class, value = score5, class="score5");
df10 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score10_class, value = score10, class="score10");

df <- rbind(df1,df5,df10)


base_size <- 9

col <- c("red","orange","yellow","white")

p1 <- ggplot(df, aes(class,idx)) + 
	geom_tile(aes(fill=df$promiscuity),colour="grey50",size=0.5)  +
	scale_fill_identity("Class", labels =c("Promiscuous1","Promiscuous5","Promiscuous10","X"), breaks = col, guide = "legend") +
	#scale_fill_gradient(low = "white", high = "red",guide="legend")  
	theme_grey(base_size = base_size) + 
	labs(x = "", y = "", title = ">25%" )  +
	coord_fixed(ratio=0.7) +
	scale_y_discrete(expand = c(0, 0),limits=c(min(df$idx):max(df$idx)),labels=x_lab) +
	#scale_y_discrete(expand = c(0, 0)) +
    scale_x_discrete(expand = c(0, 0),labels=c("P1","P5","P10")) +
	theme_bw() + 
	theme(plot.title = element_text(size = 10), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_rect(fill = NA, colour = "black", size = 1) )	+
	#theme(legend.position = "none",axis.ticks = element_blank(), axis.text.x = element_text(size = base_size, angle = 0, hjust = 0, colour = "black"), axis.text.y = element_text(size = base_size*0.8, hjust = 1, colour = "grey50"))
	theme(legend.position = "none",axis.ticks = element_blank(), axis.text.x = element_text(size = base_size, angle=300, hjust = 0, colour = "grey50"), axis.text.y = element_text(size = base_size*0.8, hjust = 1, colour = "grey50"))


ratio <- (length(x_lab)/200)
hei= as.integer(35*ratio)
#if(hei > 40){ hei = 39}

ggsave( file = paste(out_png,"_25.png",sep=""), height=hei,limitsize=FALSE )

### CUT 2, this is really stupid

## ---- CUT OFF for promiscuous binding -----------
Promiscuity_cut = 0.35	# % 
## ------------------------------------------------

for(i in c(1:length(score1))){
	if(score1[i]/n_allele > Promiscuity_cut){
		score1_class[i] = "red"
	}else{
		score1_class[i] = "white"
	}
	if(score5[i]/n_allele > Promiscuity_cut){
		score5_class[i] = "orange"
	}else{
		score5_class[i] = "white"
	}
	if(score10[i]/n_allele > Promiscuity_cut){
		score10_class[i] = "yellow"
	}else{
		score10_class[i] = "white"
	}

}

df1 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score1_class, value = score1, class="score1");
df5 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score5_class, value = score5, class="score5");
df10 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score10_class, value = score10, class="score10");

df <- rbind(df1,df5,df10)

p2 <- ggplot(df, aes(class,idx)) + 
	geom_tile(aes(fill=df$promiscuity),colour="grey50",size=0.5)  +
	scale_fill_identity("Class", labels =c("Promiscuous1","Promiscuous5","Promiscuous10","X"), breaks = col, guide = "legend") +
	#scale_fill_gradient(low = "white", high = "red",guide="legend")  
	theme_grey(base_size = base_size) + 
	labs(x = "", y = "", title = ">35%" )  +
	coord_fixed(ratio=0.7) +
	scale_y_discrete(expand = c(0, 0),limits=c(min(df$idx):max(df$idx)),labels=x_lab) +
	#scale_y_discrete(expand = c(0, 0)) +
    scale_x_discrete(expand = c(0, 0),labels=c("P1","P5","P10")) +
	theme_bw() + 
	theme(plot.title = element_text(size = 10), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_rect(fill = NA, colour = "black", size = 1) )	+
	theme(legend.position = "none",axis.ticks = element_blank(), axis.text.x = element_text(size = base_size, angle = 300, hjust = 0, colour = "grey50"), axis.text.y = element_text(size = base_size*0.8, hjust = 1, colour = "grey50"))

ggsave( file = paste(out_png,"_35.png",sep=""), height=hei,limitsize=FALSE  )

### CUT 3, this is really stupid, too


## ---- CUT OFF for promiscuous binding -----------
Promiscuity_cut = 0.5	# % 
## ------------------------------------------------

for(i in c(1:length(score1))){
	if(score1[i]/n_allele > Promiscuity_cut){
		score1_class[i] = "red"
	}else{
		score1_class[i] = "white"
	}
	if(score5[i]/n_allele > Promiscuity_cut){
		score5_class[i] = "orange"
	}else{
		score5_class[i] = "white"
	}
	if(score10[i]/n_allele > Promiscuity_cut){
		score10_class[i] = "yellow"
	}else{
		score10_class[i] = "white"
	}

}

df1 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score1_class, value = score1, class="score1");
df5 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score5_class, value = score5, class="score5");
df10 <- data.frame( idx=x_idx, seq_id = x_lab, promiscuity = score10_class, value = score10, class="score10");

df <- rbind(df1,df5,df10)

p3 <- ggplot(df, aes(class,idx)) + 
	geom_tile(aes(fill=df$promiscuity),colour="grey50",size=0.5)  +
	scale_fill_identity("Class", labels =c("Promiscuous1","Promiscuous5","Promiscuous10","X"), breaks = col, guide = "legend") +
	#scale_fill_gradient(low = "white", high = "red",guide="legend")  
	theme_grey(base_size = base_size) + 
	labs(x = "", y = "",title=">50%")  +
	coord_fixed(ratio=0.7) +
	scale_y_discrete(expand = c(0, 0),limits=c(min(df$idx):max(df$idx)),labels=x_lab) +
	#scale_y_discrete(expand = c(0, 0)) +
    scale_x_discrete(expand = c(0, 0),labels=c("P1","P5","P10")) +
	theme_bw() + 
	theme(plot.title = element_text(size = 10), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_rect(fill = NA, colour = "black", size = 1) )	+
	theme(legend.position = "none", axis.ticks = element_blank(), axis.text.x = element_text(size = base_size, angle = 300, hjust = 0, colour = "grey50"), axis.text.y = element_text(size = base_size*0.8, hjust = 1, colour = "grey50"))

ggsave( file = paste(out_png,"_50.png",sep=""), height=hei ,limitsize=FALSE )

##------------------Multiple Plots----


#grid.arrange(p1, p2, p3, legend, ncol=4, nrow=1, main="Promiscous Activity",widths=c(2.3, 2.3, 2.3,0.8))
#grid.arrange(p1, ncol=1, nrow=1, main="Promiscous Activity")

#save_plot(out_png, plot.mpg,base_aspect_ratio = 1.3)


#pdf(out_png,height=hei)

#grid.newpage()

# Create layout : nrow = 2, ncol = 2
#pushViewport(viewport(layout = grid.layout(1, 3)))

# A helper function to define a region on the layout
#define_region <- function(row, col){
#  viewport(layout.pos.row = row, layout.pos.col = col)
#} 

# Arrange the plots
#print(p1, vp = define_region(1, 1))
#print(p2, vp = define_region(1, 2))
#print(p3, vp = define_region(1, 3))

#save_plot(out_png, base_aspect_ratio = 1.3)
#ggsave( file = out_png, height=hei  )

#dev.off()

