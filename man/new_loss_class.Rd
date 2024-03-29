% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zzz-aliases.R
\name{new_loss_class}
\alias{new_loss_class}
\title{Loss}
\usage{
new_loss_class(
  classname,
  call = NULL,
  ...,
  public = list(),
  private = list(),
  inherit = NULL,
  parent_env = parent.frame()
)
}
\arguments{
\item{classname}{String, the name of the custom class. (Conventionally, CamelCase).}

\item{call}{\if{html}{\out{<div class="sourceCode r">}}\preformatted{function(y_true, y_pred)
}\if{html}{\out{</div>}}

Method to be implemented by subclasses:
Function that contains the logic for loss calculation using
\code{y_true}, \code{y_pred}.}

\item{..., public}{Additional methods or public members of the custom class.}

\item{private}{Named list of R objects (typically, functions) to include in
instance private environments. \code{private} methods will have all the same
symbols in scope as public methods (See section "Symbols in Scope"). Each
instance will have it's own \code{private} environment. Any objects
in \code{private} will be invisible from the Keras framework and the Python
runtime.}

\item{inherit}{What the custom class will subclass. By default, the base keras class.}

\item{parent_env}{The R environment that all class methods will have as a grandparent.}
}
\value{
A function that returns \code{Loss} instances, similar to the
builtin loss functions.
}
\description{
\code{new_loss_class()} is an alias for \code{\link[=Loss]{Loss()}}.
See \verb{?}\code{\link[=Loss]{Loss()}} for the full documentation.
}
\keyword{internal}
