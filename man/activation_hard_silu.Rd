% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/activations.R
\name{activation_hard_silu}
\alias{activation_hard_silu}
\alias{activation_hard_swish}
\title{Hard SiLU activation function, also known as Hard Swish.}
\usage{
activation_hard_silu(x)

activation_hard_swish(x)
}
\arguments{
\item{x}{Input tensor.}
}
\value{
A tensor, the result from applying the activation to the input tensor \code{x}.
}
\description{
It is defined as:
\itemize{
\item \code{0} if \verb{if x < -3}
\item \code{x} if \code{x > 3}
\item \code{x * (x + 3) / 6} if \verb{-3 <= x <= 3}
}

It's a faster, piecewise linear approximation of the silu activation.
}
\section{Reference}{
\itemize{
\item \href{https://arxiv.org/abs/1905.02244}{A Howard, 2019}
}
}

