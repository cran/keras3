% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optimizers.R
\name{optimizer_adam_w}
\alias{optimizer_adam_w}
\title{Optimizer that implements the AdamW algorithm.}
\usage{
optimizer_adam_w(
  learning_rate = 0.001,
  weight_decay = 0.004,
  beta_1 = 0.9,
  beta_2 = 0.999,
  epsilon = 1e-07,
  amsgrad = FALSE,
  clipnorm = NULL,
  clipvalue = NULL,
  global_clipnorm = NULL,
  use_ema = FALSE,
  ema_momentum = 0.99,
  ema_overwrite_frequency = NULL,
  name = "adamw",
  ...,
  loss_scale_factor = NULL,
  gradient_accumulation_steps = NULL
)
}
\arguments{
\item{learning_rate}{A float, a
\code{\link[=LearningRateSchedule]{LearningRateSchedule()}} instance, or
a callable that takes no arguments and returns the actual value to
use. The learning rate. Defaults to \code{0.001}.}

\item{weight_decay}{Float. If set, weight decay is applied.}

\item{beta_1}{A float value or a constant float tensor, or a callable
that takes no arguments and returns the actual value to use. The
exponential decay rate for the 1st moment estimates.
Defaults to \code{0.9}.}

\item{beta_2}{A float value or a constant float tensor, or a callable
that takes no arguments and returns the actual value to use. The
exponential decay rate for the 2nd moment estimates.
Defaults to \code{0.999}.}

\item{epsilon}{A small constant for numerical stability. This epsilon is
"epsilon hat" in the Kingma and Ba paper (in the formula just
before Section 2.1), not the epsilon in Algorithm 1 of the paper.
Defaults to 1e-7.}

\item{amsgrad}{Boolean. Whether to apply AMSGrad variant of this algorithm
from the paper "On the Convergence of Adam and beyond".
Defaults to \code{FALSE}.}

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

\item{ema_overwrite_frequency}{Int or \code{NULL}, defaults to \code{NULL}. Only used if
\code{use_ema=TRUE}. Every \code{ema_overwrite_frequency} steps of iterations,
we overwrite the model variable by its moving average.
If \code{NULL}, the optimizer
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
training. Alternately, \code{\link[=optimizer_loss_scale]{optimizer_loss_scale()}} will
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
AdamW optimization is a stochastic gradient descent method that is based on
adaptive estimation of first-order and second-order moments with an added
method to decay weights per the techniques discussed in the paper,
'Decoupled Weight Decay Regularization' by
\href{https://arxiv.org/abs/1711.05101}{Loshchilov, Hutter et al., 2019}.

According to
\href{https://arxiv.org/abs/1412.6980}{Kingma et al., 2014},
the underlying Adam method is "\emph{computationally
efficient, has little memory requirement, invariant to diagonal rescaling of
gradients, and is well suited for problems that are large in terms of
data/parameters}".
}
\section{References}{
\itemize{
\item \href{https://arxiv.org/abs/1711.05101}{Loshchilov et al., 2019}
\item \href{https://arxiv.org/abs/1412.6980}{Kingma et al., 2014} for \code{adam}
\item \href{https://openreview.net/pdf?id=ryQu7f-RZ}{Reddi et al., 2018} for \code{amsgrad}.
}
}

\seealso{
\itemize{
\item \url{https://keras.io/api/optimizers/adamw#adamw-class}
}

Other optimizers: \cr
\code{\link{optimizer_adadelta}()} \cr
\code{\link{optimizer_adafactor}()} \cr
\code{\link{optimizer_adagrad}()} \cr
\code{\link{optimizer_adam}()} \cr
\code{\link{optimizer_adamax}()} \cr
\code{\link{optimizer_ftrl}()} \cr
\code{\link{optimizer_lamb}()} \cr
\code{\link{optimizer_lion}()} \cr
\code{\link{optimizer_loss_scale}()} \cr
\code{\link{optimizer_nadam}()} \cr
\code{\link{optimizer_rmsprop}()} \cr
\code{\link{optimizer_sgd}()} \cr
}
\concept{optimizers}
