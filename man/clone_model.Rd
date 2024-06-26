% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model-creation.R
\name{clone_model}
\alias{clone_model}
\title{Clone a Functional or Sequential \code{Model} instance.}
\usage{
clone_model(
  model,
  input_tensors = NULL,
  clone_function = NULL,
  call_function = NULL,
  recursive = FALSE,
  ...
)
}
\arguments{
\item{model}{Instance of \code{Model}
(could be a Functional model or a Sequential model).}

\item{input_tensors}{Optional list of input tensors
to build the model upon. If not provided,
new \code{keras_input()} objects will be created.}

\item{clone_function}{Callable with signature \verb{function(layer)}
to be used to clone each layer in the target
model (except \code{Input} instances). It takes as argument the
layer instance to be cloned, and returns the corresponding layer
instance to be used in the model copy. If unspecified, this callable
defaults to the following serialization/deserialization function:
\code{function(layer) layer$`__class__`$from_config(layer$get_config())}.
By passing a custom callable, you can customize your copy of the
model, e.g. by wrapping certain layers of interest (you might want
to replace all \code{LSTM} instances with equivalent
\code{Bidirectional(LSTM(...))} instances, for example).
Defaults to \code{NULL}.}

\item{call_function}{Callable with signature
\verb{function(layer, ...)} to be used to call each
cloned layer and a set of inputs. It takes the layer instance,
and the call arguments, and returns the
call outputs. If unspecified, this callable defaults to
the regular \code{call()} method:
\code{function(layer, ...) do.call(layer, list(...))}.
By passing a custom callable, you can insert new layers before or
after a given layer.}

\item{recursive}{Note, This argument can only be used with
Functional models.
Boolean. Whether to recursively clone any Sequential
or Functional models encountered in the original
Sequential/Functional model. If \code{FALSE},
then inner models are cloned by calling \code{clone_function()}.
If \code{TRUE}, then inner models are cloned by calling \code{clone_model()}
with the same \code{clone_function}, \code{call_function}, and \code{recursive}
arguments. Note that in this case, \code{call_function}
will not be propagated to any Sequential model
(since it is not applicable to Sequential models).}

\item{...}{For forward/backward compatability.}
}
\value{
An instance of \code{Model} reproducing the behavior
of the original model, on top of new inputs tensors,
using newly instantiated weights. The cloned model may behave
differently from the original model if a custom \code{clone_function}
or \code{call_function} modifies a layer or layer call.
}
\description{
Model cloning is similar to calling a model on new inputs,
except that it creates new layers (and thus new weights) instead
of sharing the weights of the existing layers.

Note that
\code{clone_model()} will not preserve the uniqueness of shared objects within the
model (e.g. a single variable attached to two distinct layers will be
restored as two separate variables).
}
\section{Examples}{
\if{html}{\out{<div class="sourceCode r">}}\preformatted{# Create a test Sequential model.
model <- keras_model_sequential(input_shape = c(728)) |>
  layer_dense(32, activation = 'relu') |>
  layer_dense(1, activation = 'sigmoid')

# Create a copy of the test model (with freshly initialized weights).
new_model <- clone_model(model)
}\if{html}{\out{</div>}}

Using a \code{clone_function} to make a model deterministic by setting the
random seed everywhere:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{clone_function <- function(layer) \{
  config <- layer$get_config()
  if ("seed" \%in\% names(config))
    config$seed <- 1337L
  layer$`__class__`$from_config(config)
\}

new_model <- clone_model(model, clone_function = clone_function)
}\if{html}{\out{</div>}}

Using a \code{call_function} to add a \code{Dropout} layer after each \code{Dense} layer
(without recreating new layers):

\if{html}{\out{<div class="sourceCode r">}}\preformatted{call_function <- function(layer, ...) \{
  out <- layer(...)
  if (inherits(layer, keras$layers$Dense))
    out <- out |> layer_dropout(0.5)
  out
\}

inputs <- keras_input(c(728))
outputs <- inputs |>
  layer_dense(32, activation = 'relu') |>
  layer_dense(1, activation = 'sigmoid')
model <- keras_model(inputs, outputs)

new_model <- clone_model(
  model,
  clone_function = function(x) x, # Reuse the same layers.
  call_function = call_function,
)
new_model
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Model: "functional_5"
## +-----------------------------------+--------------------------+---------------+
## | Layer (type)                      | Output Shape             |       Param # |
## +===================================+==========================+===============+
## | keras_tensor_8 (InputLayer)       | (None, 728)              |             0 |
## +-----------------------------------+--------------------------+---------------+
## | dense_2 (Dense)                   | (None, 32)               |        23,328 |
## +-----------------------------------+--------------------------+---------------+
## | dropout (Dropout)                 | (None, 32)               |             0 |
## +-----------------------------------+--------------------------+---------------+
## | dense_3 (Dense)                   | (None, 1)                |            33 |
## +-----------------------------------+--------------------------+---------------+
## | dropout_1 (Dropout)               | (None, 1)                |             0 |
## +-----------------------------------+--------------------------+---------------+
##  Total params: 23,361 (91.25 KB)
##  Trainable params: 23,361 (91.25 KB)
##  Non-trainable params: 0 (0.00 B)

}\if{html}{\out{</div>}}

Note that subclassed models cannot be cloned by default,
since their internal layer structure is not known.
To achieve equivalent functionality
as \code{clone_model} in the case of a subclassed model, simply make sure
that the model class implements \code{get_config()}
(and optionally \code{from_config()}), and call:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{new_model <- model$`__class__`$from_config(model$get_config())
}\if{html}{\out{</div>}}

In the case of a subclassed model, you cannot using a custom
\code{clone_function}.
}

