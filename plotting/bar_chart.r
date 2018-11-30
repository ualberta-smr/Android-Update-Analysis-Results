library(ggplot2)
library(dplyr)
library(labeling)
library(scales)


data <- read.csv(file="./bar_chart.csv",head=TRUE,sep=",")

colors <- c("Not Possible" = "#EA0D30", "Might Be Possible" = "#FCC168", "Possible" = "#48D373")


ggplot(data) +
aes(x=name, y=proportion, fill=color) +
geom_col(width=0.6) +
geom_text(aes(label = count, y = label_y + .01 )) +
geom_text(aes(label = paste('(', format(round(data$proportion * 100, 1), nsmall = 1), ')%', sep=''), y = label_y - .0175) , size=2.5) +
scale_y_continuous(labels=percent, expand = c(0, 0), limits = c(0, 1.05)) +
scale_fill_manual(values=colors) +
theme_classic() +
theme(axis.text.x=element_text(angle=45,hjust=1)) +
labs(x='Comparison scenario', y='Percentage', fill='Status')
ggsave('bar_chart.pdf', dpi=300, height=5)