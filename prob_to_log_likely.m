function output = prob_to_log_likely(input)
% This function is used for converting a probability to log-likelihood
output = log(input/(1-input));
end

