library(ggplot2)
library(dplyr)
library(labeling)

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols), byrow = TRUE)
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

create_box_plot <- function(data, an_type, cm_type){
	plot <- ggplot(data, aes(x=factor(0),y=count)) +
		ggtitle(paste(paste('AN:',an_type, sep=''), paste('CM:', cm_type, sep=''),sep=" ")) +
		geom_boxplot() +
		xlab('') +
		ylab('Count') +
		theme(title=element_text(size=5), axis.text.y=element_text(size=6))
	return(plot)
}


change_types = c('identical', 'refactored', 'argument', 'body', 'deleted')
comparison_scenarios = c('A4.2_A4.3_CM10.1', 'A4.3_A4.4_CM10.2', 'A4.4_A5.0.0_CM11.0', 'A5.0.0_A5.1.0_CM12.0', 'A5.1.0_A6.0.0_CM12.1', 'A6.0.0_A7.0.0_CM13.0', 'A7.0.0_A7.1.0_CM14.0')
data <- read.csv(file="./box_plot.csv",head=TRUE,sep=",")

changes_count = length(change_types)
for (cs_index in 1:length(comparison_scenarios)) {
	comparison_scenario = comparison_scenarios[cs_index]
	plots_list <- list()
	index = 1
	for (row in 1:changes_count) {
		for (column in 2:changes_count) {
			data_frame = data[data$an_type == change_types[row] &
					     data$cm_type == change_types[column] &
						 data$versions == comparison_scenario, ]
			plots_list[[index]] <- create_box_plot(data_frame, change_types[row], change_types[column])
			index = index + 1
		}
	}
	pdf(paste("box_plot_", comparison_scenario, ".pdf", sep=''))
	multiplot(plotlist=plots_list, cols=4)
	dev.off()
}
