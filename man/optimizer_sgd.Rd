% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optimizers.R
\name{optimizer_sgd}
\alias{optimizer_sgd}
\title{Gradient descent (with momentum) optimizer.}
\usage{
optimizer_sgd(
  learning_rate = 0.01,
  momentum = 0,
  nesterov = FALSE,
  weight_decay = NULL,
  clipnorm = NULL,
  clipvalue = NULL,
  global_clipnorm = NULL,
  use_ema = FALSE,
  ema_momentum = 0.99,
  ema_overwrite_frequency = NULL,
  name = "SGD",
  ...,
  loss_scale_factor = NULL,
  gradient_accumulation_steps = NULL
)
}
\arguments{
\item{learning_rate}{A float, a
\verb{learning_rate_schedule_*} instance, or
a callable that takes no arguments and returns the actual value to
use. The learning rate. Defaults to \code{0.01}.}

\item{momentum}{float hyperparameter >= 0 that accelerates gradient descent in
the relevant direction and dampens oscillations. 0 is vanilla
gradient descent. Defaults to \code{0.0}.}

\item{nesterov}{boolean. Whether to apply Nesterov momentum.
Defaults to \code{FALSE}.}

\item{weight_decay}{Float. If set, weight decay is applied.}

\item{clipnorm}{Float. If set, the gradient of each weight is individually
clipped so that its norm is no higher than this value.}

\item{clipvalue}{Float. If set, the gradient of each weight is clipped to be
no higher than this value.}

\item{global_clipnorm}{Float. If set, the gradient of all weights is clipped
so that their global norm is no higher than this value.}

\item{use_ema}{Boolean, defaults to \code{FALSE}.
If \code{TRUE}, exponential moving average
(EMA) is applied. EMA consists of computing an exponential moving
average of the weights of the model (as the weight values change after
each training batch), and periodically overwriting the weights with
their moving average.}

\item{ema_momentum}{Float, defaults to 0.99. Only used if \code{use_ema=TRUE}.
This is the momentum to use when computing
the EMA of the model's weights:
\code{new_average = ema_momentum * old_average + (1 - ema_momentum) * current_variable_value}.}

\item{ema_overwrite_frequency}{Int or NULL, defaults to NULL. Only used if
\code{use_ema=TRUE}. Every \code{ema_overwrite_frequency} steps of iterations,
we overwrite the model variable by its moving average.
If NULL, the optimizer
does not overwrite model variables in the middle of training, and you
need to explicitly overwrite the variables at the end of training
by calling \code{optimizer$finalize_variable_values()}
(which updates the model
variables in-place). When using the built-in \code{fit()} training loop,
this happens automatically after the last epoch,
and you don't need to do anything.}

\item{name}{String. The name to use
for momentum accumulator weights created by
the optimizer.}

\item{...}{For forward/backward compatability.}

\item{loss_scale_factor}{Float or \code{NULL}. If a float, the scale factor will
be multiplied the loss before computing gradients, and the inverse of
the scale factor will be multiplied by the gradients before updating
variables. Useful for preventing underflow during mixed precision
training. Alternately, \code{optimizer_loss_scale()} will
automatically set a loss scale factor.}

\item{gradient_accumulation_steps}{Int or \code{NULL}. If an int, model and optimizer
variables will not be updated at every step; instead they will be
updated every \code{gradient_accumulation_steps} steps, using the average
value of the gradients since the last update. This is known as
"gradient accumulation". This can be useful
when your batch size is very small, in order to reduce gradient
noise at each update step. EMA frequency will look at "accumulated"
iterations value (optimizer steps // gradient_accumulation_steps).
Learning rate schedules will look at "real" iterations value
(optimizer steps).}
}
\value{
an \code{Optimizer} instance
}
\description{
Update rule for parameter \code{w} with gradient \code{g} when \code{momentum} is 0:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{w <- w - learning_rate * g
}\if{html}{\out{</div>}}

Update rule when \code{momentum} is larger than 0:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{velocity <- momentum * velocity - learning_rate * g
w <- w + velocity
}\if{html}{\out{</div>}}

When \code{nesterov=TRUE}, this rule becomes:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{velocity <- momentum * velocity - learning_rate * g
w <- w + momentum * velocity - learning_rate * g
}\if{html}{\out{</div>}}
}
\seealso{
\itemize{
\item \url{https://keras.io/api/optimizers/sgd#sgd-class}
}

Other optimizers: \cr
\code{\link{optimizer_adadelta}()} \cr
\code{\link{optimizer_adafactor}()} \cr
\code{\link{optimizer_adagrad}()} \cr
\code{\link{optimizer_adam}()} \cr
\code{\link{optimizer_adam_w}()} \cr
\code{\link{optimizer_adamax}()} \cr
\code{\link{optimizer_ftrl}()} \cr
\code{\link{optimizer_lamb}()} \cr
\code{\link{optimizer_lion}()} \cr
\code{\link{optimizer_loss_scale}()} \cr
\code{\link{optimizer_nadam}()} \cr
\code{\link{optimizer_rmsprop}()} \cr
}
\concept{optimizers}
