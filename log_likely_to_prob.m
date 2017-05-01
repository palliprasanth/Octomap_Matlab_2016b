function output = log_likely_to_prob(input)
output = 1 - (1/(1+exp(input)));
end