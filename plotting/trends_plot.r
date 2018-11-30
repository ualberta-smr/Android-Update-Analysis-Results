library(ggplot2)
library(dplyr)
library(labeling)
library(scales)

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
    pushViewport(viewport(w=unit(20, "inches"), h=unit(20, "inches"),
                          layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

create_point_line_plot <- function(data, an_type, cm_type){
  max_y = max(data$proportion) + .05
  min_y_scale = .105
	plot <- ggplot(data, aes(x=versions,y=proportion,group=1)) +
		ggtitle(paste(paste('AN:',an_type, sep=''), paste('MO:', cm_type, sep=''),sep=" ")) +
		geom_point(size=.5, colour=data$color[1]) +
    geom_line(size=.3, colour=data$color[1]) +
    scale_y_continuous(labels=percent, expand = c(0, 0), limits = c(0, max(min_y_scale, max_y))) +
		xlab('Comparison Scenario') +
		ylab('Percentage') +
		theme(title=element_text(size=5), axis.text.x=element_text(angle=45,hjust=1,size=4.5), axis.text.y=element_text(size=5.5))
	return(plot)
}


change_types = c('identical',
                'refactored_move',
                'refactored_rename',
                'refactored_inline',
                'refactored_extract',
                'argument_rename',
                'argument_reorder',
                'argument_add',
                'argument_remove',
                'argument_type_change',
                'body',
                'deleted')
data <- read.csv(file="./trends_plot.csv",head=TRUE,sep=",")

plots_list <- list()
changes_count = length(change_types)
index = 1
for (row in 1:changes_count) {
	for (column in 2:changes_count) {
		data_frame = data[data$an_type == change_types[row] & data$mo_type == change_types[column], ]
		plots_list[[index]] <- create_point_line_plot(data_frame, change_types[row], change_types[column])
		index = index + 1
	}
}


png("trends_plot.png", width=5000, height=5000, res=240)
multiplot(plotlist=plots_list, cols=11)
dev.off()
