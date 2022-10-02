#' Evaluate Performance of Normlaization Methods by Comparing Biological Variation
#' @description The function generates PCA plots of normalized DSP data of the ROIs that are treated as biological replicates by a list of normalization methods. A better normalization method is expected to yield larger biological variations between two known biological subgroups.
#' @return ggplot2 object of PCA plot.
#' @details To add some details here!
#' @export
#' @import graphics stats ggplot2
#' @param normed.data.list a list object containing the normalized DSP expression matrix under all normalization methods, each normalized matrix can be either a data.frame or matrix.
#' @param norm.methods.list a numerical vector of the method IDs to be compared, for instance, norm.methods.list = 1:17.
#' @param grouping.info a character vector describing grouping info of each ROI, must be arranged in the same order of the columns of DSP expression matrix. Each unique character in the vector is to be treated as a unique biological subgroup. For optimal visualization, it is strongly recommended to consider only two unique biological groups of interest in each round of comparison.
#' @param main title to be added to the output figure.
#' @param title.size font size of title.
norm.eval.bio.var <- function(normed.data.list, norm.methods.list, grouping.info, main="", title.size=6){

  # library(ggplot2)
  # library("ggfortify")
  # library(gridExtra)


  plots.list = list()
  plot_id = 1


  # collect PCA plots for all normalization methods on the same page:
  if(length(unique(grouping.info)) > 1){
    for (method_id in norm.methods.list) {

      data.scaled.bg_corrected.normed.pt.i = normed.data.list[[method_id]]


      for.pca = as.data.frame(t(data.scaled.bg_corrected.normed.pt.i))

      for.pca$Group = grouping.info


      myplot.keep = ggplot2::autoplot(stats::prcomp(for.pca[ ,-dim(for.pca)[2]]), data=for.pca, label=F, shape = T, colour = 'Group', frame=T, frame.type = 'norm')
      myplot.keep = myplot.keep + ggplot2::theme(axis.text=ggplot2::element_text(size=5),axis.title=ggplot2::element_text(size=5), legend.position = "none", plot.title = ggplot2::element_text(size=title.size, face = "bold"), panel.grid.minor = ggplot2::element_blank(), panel.background = ggplot2::element_blank(), axis.line = ggplot2::element_line(colour = "black"))
      if(main==""){
        myplot.keep = myplot.keep + ggplot2::ggtitle(paste(method_id, sep = ""))
      } else{
        myplot.keep = myplot.keep + ggplot2::ggtitle(paste(main, ", ", method_id, sep = ""))
      }


      plots.list[[plot_id]] = myplot.keep


      plot_id = plot_id + 1

    }

  } else{
    cat("   Found only one group, PCA plot is therefore ignored!\n")
  }


return(plots.list)
}











