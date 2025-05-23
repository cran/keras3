% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/activations.R
\name{activation_selu}
\alias{activation_selu}
\title{Scaled Exponential Linear Unit (SELU).}
\usage{
activation_selu(x)
}
\arguments{
\item{x}{Input tensor.}
}
\value{
A tensor, the result from applying the activation to the input tensor \code{x}.
}
\description{
The Scaled Exponential Linear Unit (SELU) activation function is defined as:
\itemize{
\item \code{scale * x} if \code{x > 0}
\item \code{scale * alpha * (exp(x) - 1)} if \code{x < 0}
}

where \code{alpha} and \code{scale} are pre-defined constants
(\code{alpha = 1.67326324} and \code{scale = 1.05070098}).

Basically, the SELU activation function multiplies \code{scale} (> 1) with the
output of the \code{activation_elu} function to ensure a slope larger
than one for positive inputs.

The values of \code{alpha} and \code{scale} are
chosen so that the mean and variance of the inputs are preserved
between two consecutive layers as long as the weights are initialized
correctly (see \code{\link[=initializer_lecun_normal]{initializer_lecun_normal()}})
and the number of input units is "large enough"
(see reference paper for more information).
}
\section{Notes}{
\itemize{
\item To be used together with
\code{\link[=initializer_lecun_normal]{initializer_lecun_normal()}}.
\item To be used together with the dropout variant
\code{layer_alpha_dropout()} (legacy, depracated).
}
}

\section{Reference}{
\itemize{
\item \href{https://arxiv.org/abs/1706.02515}{Klambauer et al., 2017}
}
}

\seealso{
\itemize{
\item \url{https://keras.io/api/layers/activations#selu-function}
}

Other activations: \cr
\code{\link{activation_celu}()} \cr
\code{\link{activation_elu}()} \cr
\code{\link{activation_exponential}()} \cr
\code{\link{activation_gelu}()} \cr
\code{\link{activation_glu}()} \cr
\code{\link{activation_hard_shrink}()} \cr
\code{\link{activation_hard_sigmoid}()} \cr
\code{\link{activation_hard_tanh}()} \cr
\code{\link{activation_leaky_relu}()} \cr
\code{\link{activation_linear}()} \cr
\code{\link{activation_log_sigmoid}()} \cr
\code{\link{activation_log_softmax}()} \cr
\code{\link{activation_mish}()} \cr
\code{\link{activation_relu}()} \cr
\code{\link{activation_relu6}()} \cr
\code{\link{activation_sigmoid}()} \cr
\code{\link{activation_silu}()} \cr
\code{\link{activation_soft_shrink}()} \cr
\code{\link{activation_softmax}()} \cr
\code{\link{activation_softplus}()} \cr
\code{\link{activation_softsign}()} \cr
\code{\link{activation_sparse_plus}()} \cr
\code{\link{activation_sparsemax}()} \cr
\code{\link{activation_squareplus}()} \cr
\code{\link{activation_tanh}()} \cr
\code{\link{activation_tanh_shrink}()} \cr
\code{\link{activation_threshold}()} \cr
}
\concept{activations}
