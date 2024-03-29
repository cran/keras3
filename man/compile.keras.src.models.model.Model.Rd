% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model-training.R
\name{compile.keras.src.models.model.Model}
\alias{compile.keras.src.models.model.Model}
\title{Configure a model for training.}
\usage{
\method{compile}{keras.src.models.model.Model}(
  object,
  optimizer = "rmsprop",
  loss = NULL,
  metrics = NULL,
  ...,
  loss_weights = NULL,
  weighted_metrics = NULL,
  run_eagerly = FALSE,
  steps_per_execution = 1L,
  jit_compile = "auto",
  auto_scale_loss = TRUE
)
}
\arguments{
\item{object}{Keras model object}

\item{optimizer}{String (name of optimizer) or optimizer instance. See
\verb{optimizer_*} family.}

\item{loss}{Loss function. May be:
\itemize{
\item a string (name of builtin loss function),
\item a custom function, or
\item a \code{\link{Loss}} instance (returned by the \verb{loss_*} family of functions).
}

A loss function is any callable with the signature
\code{loss = fn(y_true, y_pred)}, where \code{y_true} are the ground truth
values, and \code{y_pred} are the model's predictions.
\code{y_true} should have shape \verb{(batch_size, d1, .. dN)}
(except in the case of sparse loss functions such as
sparse categorical crossentropy which expects integer arrays of
shape \verb{(batch_size, d1, .. dN-1)}).
\code{y_pred} should have shape \verb{(batch_size, d1, .. dN)}.
The loss function should return a float tensor.}

\item{metrics}{List of metrics to be evaluated by the model during
training and testing. Each of these can be:
\itemize{
\item a string (name of a
built-in function),
\item a function, optionally with a \code{"name"} attribute or
\item a \code{\link[=Metric]{Metric()}}
instance. See the \verb{metric_*} family of functions.
}

Typically you will use
\code{metrics = c('accuracy')}. A function is any callable with the
signature \code{result = fn(y_true, y_pred)}. To specify different
metrics for different outputs of a multi-output model, you could
also pass a named list, such as
\code{metrics = list(a = 'accuracy', b = c('accuracy', 'mse'))}.
You can also pass a list to specify a metric or a list of
metrics for each output, such as
\code{metrics = list(c('accuracy'), c('accuracy', 'mse'))}
or \code{metrics = list('accuracy', c('accuracy', 'mse'))}. When you pass
the strings \code{'accuracy'} or \code{'acc'}, we convert this to one of
\code{metric_binary_accuracy()},
\code{metric_categorical_accuracy()},
\code{metric_sparse_categorical_accuracy()} based on the
shapes of the targets and of the model output. A similar
conversion is done for the strings \code{"crossentropy"}
and \code{"ce"} as well.
The metrics passed here are evaluated without sample weighting;
if you would like sample weighting to apply, you can specify
your metrics via the \code{weighted_metrics} argument instead.

If providing an anonymous R function, you can customize the printed name
during training by assigning \verb{attr(<fn>, "name") <- "my_custom_metric_name"},
or by calling \code{\link[=custom_metric]{custom_metric("my_custom_metric_name", <fn>)}}}

\item{...}{Additional arguments passed on to the \code{compile()} model method.}

\item{loss_weights}{Optional list (named or unnamed) specifying scalar
coefficients (R numerics) to weight the loss contributions of
different model outputs. The loss value that will be minimized
by the model will then be the \emph{weighted sum} of all individual
losses, weighted by the \code{loss_weights} coefficients.  If an unnamed list,
it is expected to have a 1:1 mapping to the model's outputs. If
a named list, it is expected to map output names (strings) to scalar
coefficients.}

\item{weighted_metrics}{List of metrics to be evaluated and weighted by
\code{sample_weight} or \code{class_weight} during training and testing.}

\item{run_eagerly}{Bool. If \code{TRUE}, this model's forward pass
will never be compiled. It is recommended to leave this
as \code{FALSE} when training (for best performance),
and to set it to \code{TRUE} when debugging.}

\item{steps_per_execution}{Int. The number of batches to run
during each a single compiled function call. Running multiple
batches inside a single compiled function call can
greatly improve performance on TPUs or small models with a large
R/Python overhead. At most, one full epoch will be run each
execution. If a number larger than the size of the epoch is
passed, the execution will be truncated to the size of the
epoch. Note that if \code{steps_per_execution} is set to \code{N},
\code{Callback$on_batch_begin} and \code{Callback$on_batch_end} methods
will only be called every \code{N} batches (i.e. before/after
each compiled function execution).
Not supported with the PyTorch backend.}

\item{jit_compile}{Bool or \code{"auto"}. Whether to use XLA compilation when
compiling a model. For \code{jax} and \code{tensorflow} backends,
\code{jit_compile="auto"} enables XLA compilation if the model
supports it, and disabled otherwise.
For \code{torch} backend, \code{"auto"} will default to eager
execution and \code{jit_compile=True} will run with \code{torch.compile}
with the \code{"inductor"} backend.}

\item{auto_scale_loss}{Bool. If \code{TRUE} and the model dtype policy is
\code{"mixed_float16"}, the passed optimizer will be automatically
wrapped in a \code{LossScaleOptimizer}, which will dynamically
scale the loss to prevent underflow.}
}
\value{
This is called primarily for the side effect of modifying \code{object}
in-place. The first argument \code{object} is also returned, invisibly, to
enable usage with the pipe.
}
\description{
Configure a model for training.
}
\section{Examples}{
\if{html}{\out{<div class="sourceCode r">}}\preformatted{model |> compile(
  optimizer = optimizer_adam(learning_rate = 1e-3),
  loss = loss_binary_crossentropy(),
  metrics = c(metric_binary_accuracy(),
              metric_false_negatives())
)
}\if{html}{\out{</div>}}
}

\seealso{
\itemize{
\item \url{https://keras.io/api/models/model_training_apis#compile-method}
}

Other model training: \cr
\code{\link{evaluate.keras.src.models.model.Model}()} \cr
\code{\link{predict.keras.src.models.model.Model}()} \cr
\code{\link{predict_on_batch}()} \cr
\code{\link{test_on_batch}()} \cr
\code{\link{train_on_batch}()} \cr
}
\concept{model training}
