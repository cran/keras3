


#' Applies an activation function to an output.
#'
#' @description
#'
#' # Examples
#' ```{r}
#' x <- array(c(-3, -1, 0, 2))
#' layer <- layer_activation(activation = 'relu')
#' layer(x)
#' layer <- layer_activation(activation = activation_relu)
#' layer(x)
#' layer <- layer_activation(activation = op_relu)
#' layer(x)
#' ```
#'
#' @param activation
#' Activation function. It could be a callable, or the name of
#' an activation from the `keras3::activation_*` namespace.
#'
#' @param ...
#' Base layer keyword arguments, such as `name` and `dtype`.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @inherit layer_dense return
#' @export
#' @family activation layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/core_layers/activation#activation-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/Activation>
#' @tether keras.layers.Activation
layer_activation <-
function (object, activation, ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape),
        ignore = "object")
    create_layer(keras$layers$Activation, object, args)
}


#' Applies an Exponential Linear Unit function to an output.
#'
#' @description
#' Formula:
#'
#' ```
#' f(x) = alpha * (exp(x) - 1.) for x < 0
#' f(x) = x for x >= 0
#' ```
#'
#' @param alpha
#' float, slope of negative section. Defaults to `1.0`.
#'
#' @param ...
#' Base layer keyword arguments, such as `name` and `dtype`.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @inherit layer_dense return
#' @export
#' @family activation layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/activation_layers/elu#elu-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/ELU>
#' @tether keras.layers.ELU
layer_activation_elu <-
function (object, alpha = 1, ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape),
        ignore = "object")
    create_layer(keras$layers$ELU, object, args)
}


#' Leaky version of a Rectified Linear Unit activation layer.
#'
#' @description
#' This layer allows a small gradient when the unit is not active.
#'
#' Formula:
#'
#' ```r
#' f <- function(x) ifelse(x >= 0, x, alpha * x)
#' ```
#'
#' # Examples
#' ```{r}
#' leaky_relu_layer <- layer_activation_leaky_relu(negative_slope=0.5)
#' input <- array(c(-10, -5, 0.0, 5, 10))
#' result <- leaky_relu_layer(input)
#' as.array(result)
#' ```
#'
#' @param negative_slope
#' Float >= 0.0. Negative slope coefficient.
#' Defaults to `0.3`.
#'
#' @param ...
#' Base layer keyword arguments, such as
#' `name` and `dtype`.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @inherit layer_dense return
#' @export
#' @family activation layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/activation_layers/leaky_relu#leakyrelu-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/LeakyReLU>
#' @tether keras.layers.LeakyReLU
layer_activation_leaky_relu <-
function (object, negative_slope = 0.3, ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape),
        ignore = "object")
    create_layer(keras$layers$LeakyReLU, object, args)
}


#' Parametric Rectified Linear Unit activation layer.
#'
#' @description
#' Formula:
#' ```r
#' f <- function(x) ifelse(x >= 0, x, alpha * x)
#' ```
#' where `alpha` is a learned array with the same shape as x.
#'
#' @param alpha_initializer
#' Initializer function for the weights.
#'
#' @param alpha_regularizer
#' Regularizer for the weights.
#'
#' @param alpha_constraint
#' Constraint for the weights.
#'
#' @param shared_axes
#' The axes along which to share learnable parameters for the
#' activation function. For example, if the incoming feature maps are
#' from a 2D convolution with output shape
#' `(batch, height, width, channels)`, and you wish to share parameters
#' across space so that each filter only has one set of parameters,
#' set `shared_axes=[1, 2]`.
#'
#' @param ...
#' Base layer keyword arguments, such as `name` and `dtype`.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @inherit layer_dense return
#' @export
#' @family activation layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/activation_layers/prelu#prelu-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/PReLU>
#' @tether keras.layers.PReLU
layer_activation_parametric_relu <-
function (object, alpha_initializer = "Zeros", alpha_regularizer = NULL,
    alpha_constraint = NULL, shared_axes = NULL, ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape,
        shared_axes = as_axis), ignore = "object")
    create_layer(keras$layers$PReLU, object, args)
}


#' Rectified Linear Unit activation function layer.
#'
#' @description
#' Formula:
#'
#' ```r
#' f <- function(x, max_value = Inf, negative_slope = 0, threshold = 0) {
#'  x <- max(x,0)
#'  if (x >= max_value)
#'    max_value
#'  else if (threshold <= x && x < max_value)
#'    x
#'  else
#'    negative_slope * (x - threshold)
#' }
#' ```
#'
#' # Examples
#' ```{r}
#' relu_layer <- layer_activation_relu(max_value = 10,
#'                                     negative_slope = 0.5,
#'                                     threshold = 0)
#' input <- array(c(-10, -5, 0.0, 5, 10))
#' result <- relu_layer(input)
#' as.array(result)
#' ```
#'
#' @param max_value
#' Float >= 0. Maximum activation value. `NULL` means unlimited.
#' Defaults to `NULL`.
#'
#' @param negative_slope
#' Float >= 0. Negative slope coefficient.
#' Defaults to `0.0`.
#'
#' @param threshold
#' Float >= 0. Threshold value for thresholded activation.
#' Defaults to `0.0`.
#'
#' @param ...
#' Base layer keyword arguments, such as `name` and `dtype`.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @inherit layer_dense return
#' @export
#' @family activation layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/activation_layers/relu#relu-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/ReLU>
#' @tether keras.layers.ReLU
layer_activation_relu <-
function (object, max_value = NULL, negative_slope = 0, threshold = 0,
    ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape),
        ignore = "object")
    create_layer(keras$layers$ReLU, object, args)
}


#' Softmax activation layer.
#'
#' @description
#' Formula:
#' ```
#' exp_x = exp(x - max(x))
#' f(x) = exp_x / sum(exp_x)
#' ```
#'
#' # Examples
#' ```{r}
#' softmax_layer <- layer_activation_softmax()
#' input <- op_array(c(1, 2, 1))
#' softmax_layer(input)
#' ```
#'
#' # Call Arguments
#' - `inputs`: The inputs (logits) to the softmax layer.
#' - `mask`: A boolean mask of the same shape as `inputs`. The mask
#'     specifies 1 to keep and 0 to mask. Defaults to `NULL`.
#'
#' @returns
#' Softmaxed output with the same shape as `inputs`.
#'
#' @param axis
#' Integer, or list of Integers, axis along which the softmax
#' normalization is applied.
#'
#' @param ...
#' Base layer keyword arguments, such as `name` and `dtype`.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @export
#' @family activation layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/activation_layers/softmax#softmax-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/Softmax>
#' @tether keras.layers.Softmax
layer_activation_softmax <-
function (object, axis = -1L, ...)
{
    args <- capture_args(list(axis = as_axis, input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape),
        ignore = "object")
    create_layer(keras$layers$Softmax, object, args)
}
