
% average Ein = 0.0394
% average Eout = 0.0485

Ein = 0; % percent of g(x) ~= f(x)
Eout = 0;

numruns = 1000; % number of runs
N = 100; % number of points in the training set
T = 1000; % number of points in the test set

% creating the initial weight vector
w = zeros(1, 3);

for s = 1:numruns
    trainpts = ones(N,1); % creating matrix of training points
    trainpts(:, 2) = (2)*rand(N, 1)-1; % randomizing x1 and x2
    trainpts(:, 3) = (2)*rand(N, 1)-1;
    target = (2)*rand(2,2)-1; % randomizing target function
  
% %   plot the training set with the target function
%     scatter(trainpts(:,2),trainpts(:,3));
%     hold on;
%     plot(target(:,1),target(:,2));
%     hold off;
%     
    % evaluating Yn using the target function
    for i = 1:N
        d = ((trainpts(i,2) - target(1,1))*(target(2,2)-target(1,2))) - ...
            ((trainpts(i,3) - target(1,2))*(target(2,1) - target(1,1)));
        if d > 0
            trainpts(i,4) = -1;
        else
            trainpts(i,4) = +1;
        end
    end
    
    a = (inv((trainpts(:,1:3).')*(trainpts(:, 1:3))))*...
        (trainpts(:,1:3).')*trainpts(:, 4);
    w(1,:)= a.';
    
    % evaluating the training set using current weight vector
    for k = 1:N
        d = (w(1,1) * trainpts(k,1)) + (w(1,2) * trainpts(k,2)) ...
            + (w(1,3) *trainpts(k,3));   
        trainpts(k, 5) = sign(d);
    end
    
    % counting the current number of misclassified points
    nmiss = 0;
    for k = 1:N
        if trainpts(k,4) ~= trainpts(k,5)
            nmiss = nmiss + 1;
        end
    end
    Ein = Ein + (nmiss/N); 

% %   plot the current weight vector
%     scatter(trainpts(:,2),trainpts(:,3));
%     hold on;
%     plot(target(:,1),target(:,2));
%     fplot(@(x) (-(w(s,1)+(w(s,2)*x))/w(s,3)),[-1,1]);
%     ylim([-1,1]);
%     hold off;

    testpts = ones(T,1); % creating matrix of test points
    testpts(:, 2) = (2)*rand(T, 1)-1; % randomizing x1 and x2
    testpts(:, 3) = (2)*rand(T, 1)-1;
    wrongpts = 0;
    
    % evaluate the test points. 
     for i = 1:T
         d = ((testpts(i,2) - target(1,1))*(target(2,2)-target(1,2))) - ...
             ((testpts(i,3) - target(1,2)) * (target(2,1) - target(1,1)));
         if d > 0
             testpts(i,4) = -1;
         else
             testpts(i,4) = +1;
         end
     end
    
    for k = 1:T
        result = (w(1,1) * testpts(k,1)) + (w(1,2) * testpts(k,2)) ...
            + (w(1,3) *testpts(k,3));
        testpts(k, 5) = sign(result);
    end
    
    % count number of test points misclassified
    for k = 1:T
        if testpts(k,4) ~= testpts(k,5)
            wrongpts = wrongpts + 1;
        end
    end

    % calculating the percent of wrong points
    Eout = Eout + wrongpts/T;
 
end
    
disp('average Ein:');
disp(Ein/numruns);
disp('average Eout:');
disp(Eout/numruns);
      
