
% 10601A/SV-F15: Introduction to Machine Learning
% Programming Assignment 3: Support Vector Machine with Newton's Method
%
% TASK 2: Write a routine that implements Newton's Method 
% 			 to solve dual-form support vector machine.
% ============================================================ 
% INPUT   K: the kernel matrix;
%			    C: a column vector that contains the upper bounds; 
%         params: 
%				        params.epsilon: the solution accuracy;
% 				      params.maxiter: the maximum number of iterations;
%               params.barrier: the multiplicative factor. 
% ============================================================ 
% OUTPUT  alpha: a column vector that contains the optimal coefficients. 

function alpha = svm(K, C, params)
	alpha = zeros(size(K, 1), 1); 
    % Set alpha0 to be C / 2, which will be optimum if mu is very large
    alpha = C / 2;
    % Set mu0 to be the average of the diagonal of K
    mu = 1000*mean( diag( K ) );
    % Set the beta parameter
    beta = 0.667;
    
    % Get the parameters
    epsilon = params.epsilon;
    Nmax = params.maxiter;
    b = params.barrier;
    
    % set up one matrix
    one = ones(size(alpha));
    
    for i = 1:Nmax
      % Find the gradient
      g = 0.5*(K + K')*alpha - one - mu*alpha.^(-1) + mu*(C - alpha).^(-1);
      % Find the Hessian
      H = 0.5*(K + K') + diag(mu*(alpha.^(-1)).*(alpha.^(-1)) + mu*((C - alpha).^(-1)).*((C - alpha).^(-1)));
      % Compute the Newton direction
      d = -(H \ g);
      
      % update iterators
      %i = i + 1;
      t = 1;
      
      % Perform backtracking line search
      while (f(alpha + t*d, C, K, mu) > f(alpha, C, K, mu) + 0.5*t*g.'*d)
        t = t * beta;
      end
      
      if( t > 0.99 && mu > epsilon )
        mu = mu * b;
      end 
      
      alpha = alpha + t * d;
      
      if( norm(d) <= epsilon && mu <= epsilon )
        break;
      end
    end
end

