


#' MaxNorm weight constraint.
#'
#' @description
#' Constrains the weights incident to each hidden unit
#' to have a norm less than or equal to a desired value.
#'
#' @param max_value
#' the maximum norm value for the incoming weights.
#'
#' @param axis
#' integer, axis along which to calculate weight norms.
#' For instance, in a `Dense` layer the weight matrix
#' has shape `(input_dim, output_dim)`,
#' set `axis` to `0` to constrain each weight vector
#' of length `(input_dim,)`.
#' In a `Conv2D` layer with `data_format = "channels_last"`,
#' the weight tensor has shape
#' `(rows, cols, input_depth, output_depth)`,
#' set `axis` to `[0, 1, 2]`
#' to constrain the weights of each filter tensor of size
#' `(rows, cols, input_depth)`.
#'
#' @returns A `Constraint` instance, a callable that can be passed to layer
#'   constructors or used directly by calling it with tensors.
#' @export
#' @family constraints
#' @seealso
#' + <https://keras.io/api/layers/constraints#maxnorm-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/constraints/MaxNorm>
#' @tether keras.constraints.MaxNorm
constraint_maxnorm <-
function (max_value = 2L, axis = 1L)
{
    args <- capture_args(list(max_value = as_integer, axis = as_axis))
    do.call(keras$constraints$MaxNorm, args)
}


#' MinMaxNorm weight constraint.
#'
#' @description
#' Constrains the weights incident to each hidden unit
#' to have the norm between a lower bound and an upper bound.
#'
#' @param min_value
#' the minimum norm for the incoming weights.
#'
#' @param max_value
#' the maximum norm for the incoming weights.
#'
#' @param rate
#' rate for enforcing the constraint: weights will be
#' rescaled to yield
#' op_clip?
#' `(1 - rate) * norm + rate * op_clip(norm, min_value, max_value)`.
#' Effectively, this means that rate = 1.0 stands for strict
#' enforcement of the constraint, while rate<1.0 means that
#' weights will be rescaled at each step to slowly move
#' towards a value inside the desired interval.
#'
#' @param axis
#' integer, axis along which to calculate weight norms.
#' For instance, in a `Dense` layer the weight matrix
#' has shape `(input_dim, output_dim)`,
#' set `axis` to `0` to constrain each weight vector
#' of length `(input_dim,)`.
#' In a `Conv2D` layer with `data_format = "channels_last"`,
#' the weight tensor has shape
#' `(rows, cols, input_depth, output_depth)`,
#' set `axis` to `[0, 1, 2]`
#' to constrain the weights of each filter tensor of size
#' `(rows, cols, input_depth)`.
#'
#' @inherit constraint_maxnorm return
#' @export
#' @family constraints
#' @seealso
#' + <https://keras.io/api/layers/constraints#minmaxnorm-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/constraints/MinMaxNorm>
#' @tether keras.constraints.MinMaxNorm
constraint_minmaxnorm <-
function (min_value = 0, max_value = 1, rate = 1, axis = 1L)
{
    args <- capture_args(list(axis = as_axis))
    do.call(keras$constraints$MinMaxNorm, args)
}


#' Constrains the weights to be non-negative.
#'
#' @inherit constraint_maxnorm return
#' @export
#' @family constraints
#' @seealso
#' + <https://keras.io/api/layers/constraints#nonneg-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/constraints/NonNeg>
#' @tether keras.constraints.NonNeg
constraint_nonneg <-
function ()
{
    args <- capture_args()
    do.call(keras$constraints$NonNeg, args)
}


#' Constrains the weights incident to each hidden unit to have unit norm.
#'
#' @param axis
#' integer, axis along which to calculate weight norms.
#' For instance, in a `Dense` layer the weight matrix
#' has shape `(input_dim, output_dim)`,
#' set `axis` to `0` to constrain each weight vector
#' of length `(input_dim,)`.
#' In a `Conv2D` layer with `data_format = "channels_last"`,
#' the weight tensor has shape
#' `(rows, cols, input_depth, output_depth)`,
#' set `axis` to `[0, 1, 2]`
#' to constrain the weights of each filter tensor of size
#' `(rows, cols, input_depth)`.
#'
#' @inherit constraint_maxnorm return
#' @export
#' @family constraints
#' @seealso
#' + <https://keras.io/api/layers/constraints#unitnorm-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/constraints/UnitNorm>
#' @tether keras.constraints.UnitNorm
constraint_unitnorm <-
function (axis = 1L)
{
    args <- capture_args(list(axis = as_axis))
    do.call(keras$constraints$UnitNorm, args)
}


# --------------------------------------------------------------------------------

