# TO DO: Explain here what this function is for, and how to use it.
prepare_elbo_plot_data <- function (fits, e = 1) {
  n     <- length(fits)
  labels <- names(fits)
  for (i in 1:n) {
    y <- fits[[i]]@logLiks
    fits[[i]] <- data.frame(method    = labels[i],
                            iteration = 1:length(y),
                            elbo      = y)
  }
  out        <- do.call(rbind,fits)
  out$method <- factor(out$method,labels)
  out$elbo   <- max(out$elbo) - out$elbo + e
  return(out)
}

# TO DO: Explain here what this function is for, and how to use it.
create_elbo_plot <- function (fits, k) {
  pdat <- prepare_elbo_plot_data(fits)
  plot_colors <- c("dodgerblue","orange","darkblue","red")
  plot_linetypes <- c("solid","solid","dashed","dashed")
  return(ggplot(pdat,aes(x = iteration,y = elbo,color = method,
                         linetype = method)) +
         geom_line() +
         scale_color_manual(values = plot_colors) +
         scale_linetype_manual(values = plot_linetypes) +
         scale_y_continuous(trans = "log10",breaks = 10^seq(-8,8)) +
         guides(color = "none",linetype = "none") +
         labs(x = "iteration",y = "dist. to best ELBO",
              title = paste("K =",k)) +
         theme_cowplot(font_size = 10) +
         theme(plot.title = element_text(size = 10,face = "plain")))
}
