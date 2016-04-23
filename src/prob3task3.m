% Test SVM for ML 10-601A Problem Set 3
% Cole Gulino
% November 19, 2015

% Clear workspace
clc;
clear;

% Set up struct
params.epsilon = 10^-6;
params.maxiter = 75;
params.barrier = 0.2;
format long;

% Get data
irisD = csvread('iris.csv');
% Set up other constants
C = ones(size(irisD, 1),1);

% Get the kernel matrix K
K = zeros(size(irisD,1), size(irisD,1));
for i = 1:size(irisD,1)
  for j = 1:size(irisD,1)
    % Kij = yiyjxi^Txj
    K(i,j) = irisD(i, 3)*irisD(j, 3)*[irisD(i,1:2) 1]*[irisD(j, 1:2) 1]';
  end
end

% get alphas
alpha = svm(K, C, params);
% Get positive and negative values to plot
pos = [];
neg = [];

for i = 1:size(irisD, 1)
  if( irisD(i, 3) > 0 )
    pos = [pos; irisD(i, 1:2)];
  else
    neg = [neg; irisD(i, 1:2)];
  end
end

w = [0 0 0];
% Get the weight matrix
for i = 1:size(irisD, 1)
    w = w + alpha(i)*[irisD(i, 1:2), 1]*irisD(i,3);
end
figure;
x = irisD(:,1:2);
hold on;
yper = ( - w( 1 )*x - w( 3 ) ) / w( 2 );
plot( x, yper, 'k');
scatter(pos(:,1), pos(:,2), 'r');
scatter(neg(:,1), neg(:,2), 'b');
xlim([4 7]);
ylim([2 4.5]);
xlabel('Sepal Length');
ylabel('Sepal With');
title('Iris Data Points with Decision Boundary');
hold off;