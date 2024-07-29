# This function creates a plot comparing the improvement in the ELBO
# over time for multiple LDA runs. Input argument "k" is the number of
# topics and is only used to generate the plot title. The timings
# should be in seconds (s), and these are then converted to hours (h) for
# the plot.
create_elbo_plot <- function (fits, timings, k) {
  pdat <- prepare_elbo_plot_data(fits,timings)
  plot_colors <- c("dodgerblue","orange","darkblue","red")
  plot_linetypes <- c("solid","solid","dashed","dashed")
  return(ggplot(pdat,aes(x = runtime,y = elbo,color = method,
                         linetype = method)) +
         geom_line() +
         scale_color_manual(values = plot_colors) +
         scale_linetype_manual(values = plot_linetypes) +
         scale_y_continuous(trans = "log10",breaks = 10^seq(-8,8)) +
         guides(color = "none",linetype = "none") +
         labs(x = "runtime (h)",y = "dist. to best ELBO",
              title = paste("K =",k)) +
         theme_cowplot(font_size = 10) +
         theme(plot.title = element_text(size = 10,face = "plain")))
}

# This is used by create_elbo_plot to generate the data frame passed
# as input to ggplot().
prepare_elbo_plot_data <- function (fits, timings, e = 1) {
  n     <- length(fits)
  labels <- names(fits)
  for (i in 1:n) {
    y <- fits[[i]]@logLiks
    fits[[i]] <-
      data.frame(method    = labels[i],
                 iteration = 1:length(y),
                 runtime   = seq(0,timings[i]/60^2,length.out = length(y)),
                 elbo      = y)
  }
  out        <- do.call(rbind,fits)
  out$method <- factor(out$method,labels)
  out$elbo   <- max(out$elbo) - out$elbo + e
  return(out)
}

