% N Element Linear Array Beam Steering & Directivity Analysis
clear; clc; close all;

freq = 2.4e9; c = 3e8; lambda = c / freq; d = lambda / 2; beta = 2 * pi / lambda;
theta = linspace(0, 2*pi, 1000); 

% PROOF OF BEAM STEERING (N = 8)

figure('Name', 'Proof of Beam Steering', 'NumberTitle', 'off', 'Position', [100, 100, 900, 300]);
angles = [-45, 0, 50]; % We will steer to these three angles
N = 8; % Fixed number of elements

for i = 1:length(angles)
    theta0 = angles(i);
    alpha = -beta * d * cosd(90 - theta0); 
    psi = beta * d * cos(theta) + alpha;
    AF = abs(sin(N * psi / 2) ./ (N * sin(psi / 2)));
    AF(isnan(AF)) = 1; 
    
    subplot(1, 3, i);
    polarplot(theta, AF, 'LineWidth', 2, 'Color', [0 0.4470 0.7410]);
    ax = gca; ax.ThetaZeroLocation = 'top'; ax.RAxis.Label.String = '';
    title(sprintf('Steered to %d°', theta0), 'FontSize', 12);
end

% PROOF OF DIRECTIVITY (Comparing N=4 vs N=16)

figure('Name', 'Effect of N on Directivity', 'NumberTitle', 'off', 'Position', [150, 150, 600, 300]);
N_values = [4, 16]; % Testing a small vs large array
theta0_fixed = 30;  % Fixed steering angle

for i = 1:length(N_values)
    N_test = N_values(i);
    alpha = -beta * d * cosd(90 - theta0_fixed); 
    psi = beta * d * cos(theta) + alpha;
    AF = abs(sin(N_test * psi / 2) ./ (N_test * sin(psi / 2)));
    AF(isnan(AF)) = 1; 
    
    subplot(1, 2, i);
    polarplot(theta, AF, 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980]);
    ax = gca; ax.ThetaZeroLocation = 'top'; ax.RAxis.Label.String = '';
    title(sprintf('N = %d Elements', N_test), 'FontSize', 12);
end