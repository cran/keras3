% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/callbacks.R
\name{callback_reduce_lr_on_plateau}
\alias{callback_reduce_lr_on_plateau}
\title{Reduce learning rate when a metric has stopped improving.}
\usage{
callback_reduce_lr_on_plateau(
  monitor = "val_loss",
  factor = 0.1,
  patience = 10L,
  verbose = 0L,
  mode = "auto",
  min_delta = 1e-04,
  cooldown = 0L,
  min_lr = 0,
  ...
)
}
\arguments{
\item{monitor}{String. Quantity to be monitored.}

\item{factor}{Float. Factor by which the learning rate will be reduced.
\code{new_lr = lr * factor}.}

\item{patience}{Integer. Number of epochs with no improvement after which
learning rate will be reduced.}

\item{verbose}{Integer. 0: quiet, 1: update messages.}

\item{mode}{String. One of \verb{\{'auto', 'min', 'max'\}}. In \code{'min'} mode,
the learning rate will be reduced when the
quantity monitored has stopped decreasing; in \code{'max'} mode it will
be reduced when the quantity monitored has stopped increasing; in
\code{'auto'} mode, the direction is automatically inferred from the name
of the monitored quantity.}

\item{min_delta}{Float. Threshold for measuring the new optimum, to only focus
on significant changes.}

\item{cooldown}{Integer. Number of epochs to wait before resuming normal
operation after the learning rate has been reduced.}

\item{min_lr}{Float. Lower bound on the learning rate.}

\item{...}{For forward/backward compatability.}
}
\value{
A \code{Callback} instance that can be passed to \code{\link[=fit.keras.src.models.model.Model]{fit.keras.src.models.model.Model()}}.
}
\description{
Models often benefit from reducing the learning rate by a factor
of 2-10 once learning stagnates. This callback monitors a
quantity and if no improvement is seen for a 'patience' number
of epochs, the learning rate is reduced.
}
\section{Examples}{
\if{html}{\out{<div class="sourceCode r">}}\preformatted{reduce_lr <- callback_reduce_lr_on_plateau(monitor = 'val_loss', factor = 0.2,
                                           patience = 5, min_lr = 0.001)
model \%>\% fit(x_train, y_train, callbacks = list(reduce_lr))
}\if{html}{\out{</div>}}
}

\seealso{
\itemize{
\item \url{https://keras.io/api/callbacks/reduce_lr_on_plateau#reducelronplateau-class}
}

Other callbacks: \cr
\code{\link{Callback}()} \cr
\code{\link{callback_backup_and_restore}()} \cr
\code{\link{callback_csv_logger}()} \cr
\code{\link{callback_early_stopping}()} \cr
\code{\link{callback_lambda}()} \cr
\code{\link{callback_learning_rate_scheduler}()} \cr
\code{\link{callback_model_checkpoint}()} \cr
\code{\link{callback_remote_monitor}()} \cr
\code{\link{callback_swap_ema_weights}()} \cr
\code{\link{callback_tensorboard}()} \cr
\code{\link{callback_terminate_on_nan}()} \cr
}
\concept{callbacks}
