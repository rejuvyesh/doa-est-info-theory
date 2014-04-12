% Plots all the plots as presented in the paper
%
% Author: Arpit Jangid, Jayesh Kumar Gupta, 2014.
%
% Contact: Jayesh Kumar Gupta http://rejuvyesh.com
%          Indian Institute of Technology, Kanpur, India


% o is order here
T     = [0.15 0.30 0.50];
fs    = 44100;

for i =1:3
    L = ceil(T60(i)*fs*0.5);  
    for o = 2: 10
        %     [rmse_gcc(o-1), rmse_mi(o-1)] =  run1(o); 
        [rmse_mi(o-1)] =  run(o,L,T60(i)); 
    end

    % for plotting the first graph
    j = 2:10;
    color = ['b' 'g' 'r'];
    plot(j,rmse_mi,color(i));
    hold on ;
end
print -dpng plot1.png
close;

% plot 2
for i = 2:10
    multiple(i-1) = 0.1*i;
end
for i = 1:2
    for k = 1:9
        L = ceil(T(i)*fs*multiple(k));
        [rmse_mi(k), rmse_gcc(k)] =  run(10,L,T(i));
    end

    plot(multiple, rmse_mi, '--');
    hold on;
    plot(multiple, rmse_gcc./100, '-');
    hold on;
end
print -dpng plot2.png

% plot 3
clear all; 
T = [0.1:0.1:0.5];
fs = 44100;
for i = 1:5
    L = ceil(T(i)*fs*0.5);
    [rmse_mi(i), rmse_gcc(i)] =  run(10,L,T(i));
end
figure;
plot(T,rmse_mi, '--');
hold on;
plot(T,rmse_gcc./100, '-');
print -dpng plot3.png