


#' Additive attention layer, a.k.a. Bahdanau-style attention.
#'
#' @description
#' Inputs are a list with 2 or 3 elements:
#' 1. A `query` tensor of shape `(batch_size, Tq, dim)`.
#' 2. A `value` tensor of shape `(batch_size, Tv, dim)`.
#' 3. A optional `key` tensor of shape `(batch_size, Tv, dim)`. If none
#'     supplied, `value` will be used as `key`.
#'
#' The calculation follows the steps:
#' 1. Calculate attention scores using `query` and `key` with shape
#'     `(batch_size, Tq, Tv)` as a non-linear sum
#'     `scores = reduce_sum(tanh(query + key), axis=-1)`.
#' 2. Use scores to calculate a softmax distribution with shape
#'     `(batch_size, Tq, Tv)`.
#' 3. Use the softmax distribution to create a linear combination of `value`
#'     with shape `(batch_size, Tq, dim)`.
#'
#' # Call Arguments
#' - `inputs`: List of the following tensors:
#'     - `query`: Query tensor of shape `(batch_size, Tq, dim)`.
#'     - `value`: Value tensor of shape `(batch_size, Tv, dim)`.
#'     - `key`: Optional key tensor of shape `(batch_size, Tv, dim)`. If
#'         not given, will use `value` for both `key` and `value`, which is
#'         the most common case.
#' - `mask`: List of the following tensors:
#'     - `query_mask`: A boolean mask tensor of shape `(batch_size, Tq)`.
#'         If given, the output will be zero at the positions where
#'         `mask==FALSE`.
#'     - `value_mask`: A boolean mask tensor of shape `(batch_size, Tv)`.
#'         If given, will apply the mask such that values at positions
#'          where `mask==FALSE` do not contribute to the result.
#' - `return_attention_scores`: bool, it `TRUE`, returns the attention scores
#'     (after masking and softmax) as an additional output argument.
#' - `training`: Python boolean indicating whether the layer should behave in
#'     training mode (adding dropout) or in inference mode (no dropout).
#' - `use_causal_mask`: Boolean. Set to `TRUE` for decoder self-attention. Adds
#'     a mask such that position `i` cannot attend to positions `j > i`.
#'     This prevents the flow of information from the future towards the
#'     past. Defaults to `FALSE`.
#'
#' # Output
#' Attention outputs of shape `(batch_size, Tq, dim)`.
#' (Optional) Attention scores after masking and softmax with shape
#'     `(batch_size, Tq, Tv)`.
#'
#' @param use_scale
#' If `TRUE`, will create a scalar variable to scale the
#' attention scores.
#'
#' @param dropout
#' Float between 0 and 1. Fraction of the units to drop for the
#' attention scores. Defaults to `0.0`.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @param ...
#' For forward/backward compatability.
#'
#' @inherit layer_dense return
#' @export
#' @family attention layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/attention_layers/additive_attention#additiveattention-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/AdditiveAttention>
#' @tether keras.layers.AdditiveAttention
layer_additive_attention <-
function (object, use_scale = TRUE, dropout = 0, ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape),
        ignore = "object")
    create_layer(keras$layers$AdditiveAttention, object, args)
}


#' Dot-product attention layer, a.k.a. Luong-style attention.
#'
#' @description
#' Inputs are a list with 2 or 3 elements:
#' 1. A `query` tensor of shape `(batch_size, Tq, dim)`.
#' 2. A `value` tensor of shape `(batch_size, Tv, dim)`.
#' 3. A optional `key` tensor of shape `(batch_size, Tv, dim)`. If none
#'     supplied, `value` will be used as a `key`.
#'
#' The calculation follows the steps:
#' 1. Calculate attention scores using `query` and `key` with shape
#'     `(batch_size, Tq, Tv)`.
#' 2. Use scores to calculate a softmax distribution with shape
#'     `(batch_size, Tq, Tv)`.
#' 3. Use the softmax distribution to create a linear combination of `value`
#'     with shape `(batch_size, Tq, dim)`.
#'
#' # Call Arguments
#' - `inputs`: List of the following tensors:
#'     - `query`: Query tensor of shape `(batch_size, Tq, dim)`.
#'     - `value`: Value tensor of shape `(batch_size, Tv, dim)`.
#'     - `key`: Optional key tensor of shape `(batch_size, Tv, dim)`. If
#'         not given, will use `value` for both `key` and `value`, which is
#'         the most common case.
#' - `mask`: List of the following tensors:
#'     - `query_mask`: A boolean mask tensor of shape `(batch_size, Tq)`.
#'         If given, the output will be zero at the positions where
#'         `mask==FALSE`.
#'     - `value_mask`: A boolean mask tensor of shape `(batch_size, Tv)`.
#'         If given, will apply the mask such that values at positions
#'          where `mask==FALSE` do not contribute to the result.
#' - `return_attention_scores`: bool, it `TRUE`, returns the attention scores
#'     (after masking and softmax) as an additional output argument.
#' - `training`: Python boolean indicating whether the layer should behave in
#'     training mode (adding dropout) or in inference mode (no dropout).
#' - `use_causal_mask`: Boolean. Set to `TRUE` for decoder self-attention. Adds
#'     a mask such that position `i` cannot attend to positions `j > i`.
#'     This prevents the flow of information from the future towards the
#'     past. Defaults to `FALSE`.
#'
#' # Output
#' Attention outputs of shape `(batch_size, Tq, dim)`.
#' (Optional) Attention scores after masking and softmax with shape
#'     `(batch_size, Tq, Tv)`.
#'
#' @param use_scale
#' If `TRUE`, will create a scalar variable to scale the
#' attention scores.
#'
#' @param dropout
#' Float between 0 and 1. Fraction of the units to drop for the
#' attention scores. Defaults to `0.0`.
#'
#' @param seed
#' An integer to use as random seed in case of `dropout`.
#'
#' @param score_mode
#' Function to use to compute attention scores, one of
#' `{"dot", "concat"}`. `"dot"` refers to the dot product between the
#' query and key vectors. `"concat"` refers to the hyperbolic tangent
#' of the concatenation of the `query` and `key` vectors.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @param ...
#' For forward/backward compatability.
#'
#' @inherit layer_dense return
#' @export
#' @family attention layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/attention_layers/attention#attention-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/Attention>
#' @tether keras.layers.Attention
layer_attention <-
function (object, use_scale = FALSE, score_mode = "dot", dropout = 0,
    seed = NULL, ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape),
        ignore = "object")
    create_layer(keras$layers$Attention, object, args)
}


#' Grouped Query Attention layer.
#'
#' @description
#' This is an implementation of grouped-query attention introduced by
#' [Ainslie et al., 2023](https://arxiv.org/abs/2305.13245). Here
#' `num_key_value_heads` denotes number of groups, setting
#' `num_key_value_heads` to 1 is equivalent to multi-query attention, and
#' when `num_key_value_heads` is equal to `num_query_heads` it is equivalent
#' to multi-head attention.
#'
#' This layer first projects `query`, `key`, and `value` tensors. Then, `key`
#' and `value` are repeated to match the number of heads of `query`.
#'
#' Then, the `query` is scaled and dot-producted with `key` tensors. These are
#' softmaxed to obtain attention probabilities. The value tensors are then
#' interpolated by these probabilities and concatenated back to a single
#' tensor.
#'
#' # Call Arguments
#' - `query`: Query tensor of shape `(batch_dim, target_seq_len, feature_dim)`,
#'     where `batch_dim` is batch size, `target_seq_len` is the length of
#'     target sequence, and `feature_dim` is dimension of feature.
#' - `value`: Value tensor of shape `(batch_dim, source_seq_len, feature_dim)`,
#'     where `batch_dim` is batch size, `source_seq_len` is the length of
#'     source sequence, and `feature_dim` is dimension of feature.
#' - `key`: Optional key tensor of shape
#'     `(batch_dim, source_seq_len, feature_dim)`. If not given, will use
#'     `value` for both `key` and `value`, which is most common case.
#' - `attention_mask`: A boolean mask of shape
#'     `(batch_dim, target_seq_len, source_seq_len)`, that prevents
#'     attention to certain positions. The boolean mask specifies which
#'     query elements can attend to which key elements, where 1 indicates
#'     attention and 0 indicates no attention. Broadcasting can happen for
#'     the missing batch dimensions and the head dimension.
#' - `return_attention_scores`: A boolean to indicate whether the output
#'     should be `(attention_output, attention_scores)` if `TRUE`, or
#'     `attention_output` if `FALSE`. Defaults to `FALSE`.
#' - `training`: Python boolean indicating whether the layer should behave in
#'     training mode (adding dropout) or in inference mode (no dropout).
#'     Will go with either using the training mode of the parent
#'     layer/model or `FALSE` (inference) if there is no parent layer.
#' - `use_causal_mask`: A boolean to indicate whether to apply a causal mask to
#'     prevent tokens from attending to future tokens (e.g., used in a
#'     decoder Transformer).
#'
#' @returns
#' attention_output: Result of the computation, of shape
#'     `(batch_dim, target_seq_len, feature_dim)`, where `target_seq_len`
#'     is for target sequence length and `feature_dim` is the query input
#'     last dim.
#' attention_scores: (Optional) attention coefficients of shape
#'     `(batch_dim, num_query_heads, target_seq_len, source_seq_len)`.
#'
#' @param head_dim
#' Size of each attention head.
#'
#' @param num_query_heads
#' Number of query attention heads.
#'
#' @param num_key_value_heads
#' Number of key and value attention heads.
#'
#' @param dropout
#' Dropout probability.
#'
#' @param use_bias
#' Boolean, whether the dense layers use bias vectors/matrices.
#'
#' @param flash_attention
#' If `NULL`, the layer attempts to use flash
#' attention for faster and more memory-efficient attention
#' computations when possible. This behavior can be configured using
#' `config_enable_flash_attention()` or
#' `config_disable_flash_attention()`.
#'
#' @param kernel_initializer
#' Initializer for dense layer kernels.
#'
#' @param bias_initializer
#' Initializer for dense layer biases.
#'
#' @param kernel_regularizer
#' Regularizer for dense layer kernels.
#'
#' @param bias_regularizer
#' Regularizer for dense layer biases.
#'
#' @param activity_regularizer
#' Regularizer for dense layer activity.
#'
#' @param kernel_constraint
#' Constraint for dense layer kernels.
#'
#' @param bias_constraint
#' Constraint for dense layer kernels.
#'
#' @param seed
#' Optional integer to seed the dropout layer.
#'
#' @param object
#' Object to compose the layer with. A tensor, array, or sequential model.
#'
#' @param ...
#' For forward/backward compatability.
#'
#' @export
#' @family attention layers
#' @family layers
# @seealso
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/GroupQueryAttention>
#' @tether keras.layers.GroupQueryAttention
layer_group_query_attention <-
function (object, head_dim, num_query_heads, num_key_value_heads,
    dropout = 0, use_bias = TRUE, flash_attention = NULL, kernel_initializer = "glorot_uniform",
    bias_initializer = "zeros", kernel_regularizer = NULL, bias_regularizer = NULL,
    activity_regularizer = NULL, kernel_constraint = NULL, bias_constraint = NULL,
    seed = NULL, ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape),
        ignore = "object")
    create_layer(keras$layers$GroupQueryAttention, object, args)
}


#' Multi Head Attention layer.
#'
#' @description
#' This is an implementation of multi-headed attention as described in the
#' paper "Attention is all you Need"
#' [Vaswani et al., 2017](https://arxiv.org/abs/1706.03762).
#' If `query`, `key,` `value` are the same, then
#' this is self-attention. Each timestep in `query` attends to the
#' corresponding sequence in `key`, and returns a fixed-width vector.
#'
#' This layer first projects `query`, `key` and `value`. These are
#' (effectively) a list of tensors of length `num_attention_heads`, where the
#' corresponding shapes are `(batch_size, <query dimensions>, key_dim)`,
#' `(batch_size, <key/value dimensions>, key_dim)`,
#' `(batch_size, <key/value dimensions>, value_dim)`.
#'
#' Then, the query and key tensors are dot-producted and scaled. These are
#' softmaxed to obtain attention probabilities. The value tensors are then
#' interpolated by these probabilities, then concatenated back to a single
#' tensor.
#'
#' Finally, the result tensor with the last dimension as `value_dim` can take
#' a linear projection and return.
#'
#' # Call Arguments
#' - `query`: Query tensor of shape `(B, T, dim)`, where `B` is the batch size,
#'     `T` is the target sequence length, and dim is the feature dimension.
#' - `value`: Value tensor of shape `(B, S, dim)`, where `B` is the batch size,
#'     `S` is the source sequence length, and dim is the feature dimension.
#' - `key`: Optional key tensor of shape `(B, S, dim)`. If not given, will
#'     use `value` for both `key` and `value`, which is the most common
#'     case.
#' - `attention_mask`: a boolean mask of shape `(B, T, S)`, that prevents
#'     attention to certain positions. The boolean mask specifies which
#'     query elements can attend to which key elements, 1 indicates
#'     attention and 0 indicates no attention. Broadcasting can happen for
#'     the missing batch dimensions and the head dimension.
#' - `return_attention_scores`: A boolean to indicate whether the output should
#'     be `(attention_output, attention_scores)` if `TRUE`, or
#'     `attention_output` if `FALSE`. Defaults to `FALSE`.
#' - `training`: Python boolean indicating whether the layer should behave in
#'     training mode (adding dropout) or in inference mode (no dropout).
#'     Will go with either using the training mode of the parent
#'     layer/model, or `FALSE` (inference) if there is no parent layer.
#' - `use_causal_mask`: A boolean to indicate whether to apply a causal mask to
#'     prevent tokens from attending to future tokens (e.g., used in a
#'     decoder Transformer).
#'
#'
#' # Call return
#' - attention_output: The result of the computation, of shape `(B, T, E)`,
#'     where `T` is for target sequence shapes and `E` is the query input
#'     last dimension if `output_shape` is `NULL`. Otherwise, the
#'     multi-head outputs are projected to the shape specified by
#'     `output_shape`.
#' - attention_scores: (Optional) multi-head attention coefficients over
#'     attention axes.
#'
#' # Properties
#' A `MultiHeadAttention` `Layer` instance has the following additional read-only properties:
#'
#' - `attention_axes`
#' - `dropout`
#' - `key_dense`
#' - `key_dim`
#' - `num_heads`
#' - `output_dense`
#' - `output_shape`
#' - `query_dense`
#' - `use_bias`
#' - `value_dense`
#' - `value_dim`
#'
#' @param num_heads
#' Number of attention heads.
#'
#' @param key_dim
#' Size of each attention head for query and key.
#'
#' @param value_dim
#' Size of each attention head for value.
#'
#' @param dropout
#' Dropout probability.
#'
#' @param use_bias
#' Boolean, whether the dense layers use bias vectors/matrices.
#'
#' @param output_shape
#' The expected shape of an output tensor, besides the batch
#' and sequence dims. If not specified, projects back to the query
#' feature dim (the query input's last dimension).
#'
#' @param attention_axes
#' axes over which the attention is applied. `NULL` means
#' attention over all axes, but batch, heads, and features.
#'
#' @param flash_attention
#' If `NULL`, the layer attempts to use flash
#' attention for faster and more memory-efficient attention
#' computations when possible. This behavior can be configured using
#' `config_enable_flash_attention()` or
#' `config_disable_flash_attention()`.
#'
#' @param kernel_initializer
#' Initializer for dense layer kernels.
#'
#' @param bias_initializer
#' Initializer for dense layer biases.
#'
#' @param kernel_regularizer
#' Regularizer for dense layer kernels.
#'
#' @param bias_regularizer
#' Regularizer for dense layer biases.
#'
#' @param activity_regularizer
#' Regularizer for dense layer activity.
#'
#' @param kernel_constraint
#' Constraint for dense layer kernels.
#'
#' @param bias_constraint
#' Constraint for dense layer kernels.
#'
#' @param seed
#' Optional integer to seed the dropout layer.
#'
#' @param ...
#' For forward/backward compatability.
#'
#' @param inputs
#' see description
#'
#' @inherit layer_dense return
#' @export
#' @family attention layers
#' @family layers
#' @seealso
#' + <https://keras.io/api/layers/attention_layers/multi_head_attention#multiheadattention-class>
#  + <https://www.tensorflow.org/api_docs/python/tf/keras/layers/MultiHeadAttention>
#' @tether keras.layers.MultiHeadAttention
layer_multi_head_attention <-
function (inputs, num_heads, key_dim, value_dim = NULL, dropout = 0,
    use_bias = TRUE, output_shape = NULL, attention_axes = NULL, flash_attention=NULL,
    kernel_initializer = "glorot_uniform", bias_initializer = "zeros",
    kernel_regularizer = NULL, bias_regularizer = NULL, activity_regularizer = NULL,
    kernel_constraint = NULL, bias_constraint = NULL, seed = NULL, ...)
{
    args <- capture_args(list(input_shape = normalize_shape,
        batch_size = as_integer, batch_input_shape = normalize_shape,
        num_heads = as_integer, key_dim = as_integer, value_dim = as_integer,
        attention_axes = as_integer), ignore = "inputs")
    layer <- create_layer(keras$layers$MultiHeadAttention, NULL, args)
    if (missing(inputs) || is.null(inputs))
        return(layer)
    if (!is.list(inputs))
        inputs <- list(inputs)
    do.call(layer, inputs)
}
