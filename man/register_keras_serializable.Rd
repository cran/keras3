% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model-persistence.R
\name{register_keras_serializable}
\alias{register_keras_serializable}
\title{Registers a custom object with the Keras serialization framework.}
\usage{
register_keras_serializable(object, name = NULL, package = NULL)
}
\arguments{
\item{object}{A keras object.}

\item{name}{The name to serialize this class under in this package.}

\item{package}{The package that this class belongs to. This is used for the
\code{key} (which is \code{"package>name"}) to identify the class.
Defaults to the current package name, or \code{"Custom"} outside of a package.}
}
\value{
\code{object} is returned invisibly, for convenient piping. This is
primarily called for side effects.
}
\description{
This function registers a custom class or function with the Keras custom
object registry, so that it can be serialized and deserialized without
needing an entry in the user-provided \code{custom_objects} argument. It also injects a
function that Keras will call to get the object's serializable string key.

Note that to be serialized and deserialized, classes must implement the
\code{get_config()} method. Functions do not have this requirement.

The object will be registered under the key \code{'package>name'} where \code{name},
defaults to the object name if not passed.
}
\section{Examples}{
\if{html}{\out{<div class="sourceCode r">}}\preformatted{# Note that `'my_package'` is used as the `package` argument here, and since
# the `name` argument is not provided, `'MyDense'` is used as the `name`.
layer_my_dense <- Layer("MyDense")
register_keras_serializable(layer_my_dense, package = "my_package")

MyDense <- environment(layer_my_dense)$`__class__` # the python class obj
stopifnot(exprs = \{
  get_registered_object('my_package>MyDense') == MyDense
  get_registered_name(MyDense) == 'my_package>MyDense'
\})
}\if{html}{\out{</div>}}
}

\seealso{
Other saving and loading functions: \cr
\code{\link{export_savedmodel.keras.src.models.model.Model}()} \cr
\code{\link{layer_tfsm}()} \cr
\code{\link{load_model}()} \cr
\code{\link{load_model_weights}()} \cr
\code{\link{save_model}()} \cr
\code{\link{save_model_config}()} \cr
\code{\link{save_model_weights}()} \cr
\code{\link{with_custom_object_scope}()} \cr

Other serialization utilities: \cr
\code{\link{deserialize_keras_object}()} \cr
\code{\link{get_custom_objects}()} \cr
\code{\link{get_registered_name}()} \cr
\code{\link{get_registered_object}()} \cr
\code{\link{serialize_keras_object}()} \cr
\code{\link{with_custom_object_scope}()} \cr
}
\concept{saving and loading functions}
\concept{serialization utilities}
