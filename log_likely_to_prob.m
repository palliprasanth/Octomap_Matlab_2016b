function output = log_likely_to_prob(input)
% This function is used for converting a log-likelihood to probability 
output = 1 - (1/(1+exp(input)));
end