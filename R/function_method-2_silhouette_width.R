#' Evaluate Performance of Normlaization Methods by Comparing silhouette width
#' @description The function generates violin plot of silhouette widths basded on normalized DSP data and known biological groups of interest each ROI belongs to. A better normalization is expected to yield higher values of silhouette width, which indicate higher chance of correctly classifying each ROI into the biological group it actually belongs to.
#' @return ggplot2 object of violin plot. A numerical table of data.frame class will be returned if \code{"return.values.only"} is set as TRUE.
#' @details To add some details here!
#' @export
#' @importFrom cluster daisy silhouette
#' @import graphics stats ggplot2
#' @param normed.data.list a list object containing the normalized DSP expression matrix under all normalization methods, each normalized matrix can be either a data.frame or matrix.
#' @param norm.methods.list a numerical vector of the method IDs to be compared, for instance, norm.methods.list = 1:17.
#' @param grouping.info a character vector describing grouping info of each ROI, must be arranged in the same order of the columns of DSP expression matrix. Each unique character in the vector is to be treated as a unique biological subgroup.
#' @param main title to be added to the output figure.
#' @param title.size font size of title.
#' @param return.values.only if TRUE, then only numerical table of computed silhouett widths, instead of violin plot, will be returned.
norm.eval.silhouette.width <- function(normed.data.list, norm.methods.list, grouping.info, main="", title.size=7, return.values.only=F){

  # library(ggplot2)
  # library("ggfortify")
  # library(gridExtra)
  # library (cluster)
  # library(arules)


  grp.uniq = sort(unique(grouping.info))


  if(length(unique(grouping.info)) > 1){

    silhouette.width.collect = matrix(NA, nrow = 2, ncol = 2)

    for (method_id in norm.methods.list) {

      data.norm.i.t = t(normed.data.list[[method_id]])

      dis.m = daisy(data.norm.i.t)

      cluster.use = rep(NA, length = nrow(data.norm.i.t))
      for (type_id in 1:length(grp.uniq)) {
        cluster.use[grep(grp.uniq[type_id], row.names(data.norm.i.t))] = type_id
        cluster.use[grouping.info==grp.uniq[type_id]] = type_id

      }
      names(cluster.use) = row.names(data.norm.i.t)

      sil2 = silhouette (cluster.use, dis.m)

      silhouette.width.collect.temp = cbind(sil2[ ,3], rep(method_id, nrow(sil2)))

      silhouette.width.collect = rbind(silhouette.width.collect, silhouette.width.collect.temp)


    }

    silhouette.width.collect = as.data.frame(silhouette.width.collect[-1:-2, ])

    names(silhouette.width.collect) = c("Silhouette_Width", "Method")
    silhouette.width.collect$Silhouette_Width = as.numeric(silhouette.width.collect$Silhouette_Width)

    silhouette.width.collect$Method = as.factor(silhouette.width.collect$Method)

    # Change violin plot colors by groups
    myplot.keep = ggplot2::ggplot(silhouette.width.collect, aes(x=Method, y=Silhouette_Width, fill=Method)) +
      ggplot2::geom_violin(trim=T)+ ggplot2::geom_boxplot(width=0.1) + ggplot2::ggtitle(main)+
      ggplot2::theme(axis.title.x=ggplot2::element_blank(), axis.text.x=ggplot2::element_blank(), axis.ticks.x=ggplot2::element_blank(),
            plot.title = ggplot2::element_text(size=title.size, face = "bold"),
            panel.grid.minor = ggplot2::element_blank(), panel.background = ggplot2::element_blank(), axis.line = ggplot2::element_line(colour = "black"))

    myplot.keep = myplot.keep + ggplot2::geom_hline(yintercept=0, linetype="dashed", color = "black", size=1.2)

    if(!return.values.only){
      return(myplot.keep)
    } else{
      return(silhouette.width.collect)
    }


  } else{

    cat("   Found only one group, silhouette width plot is therefore ignored!\n")

    return(NULL)
  }



}
