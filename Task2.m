%% Task 2 for runTwoSeriesLinkSim.m

% Initialize Parameters
K_Values = [1, 5, 15, 50, 100];    % K - the number of packets in the application message
p_range = linspace(0.05, 0.9, 100);    % p - the probability of failure
N = 1000;                   % N - the number of simulations to run

% Looping through each K value
for k = 1:length(K_Values)
    K = K_Values(k);
    
    % Arrays for calculated and simulated results
    calculatedResults = zeros(size(p_range));
    simulatedResults = zeros(size(p_range));
    
    % Calculate results for each p value
    for i = 1:length(p_range)
        p = p_range(i);
        calculatedResults(i) = (K) / ((1 - p)^2); % Calculated result
        simulatedResults(i) = runTwoSeriesLinkSim(K, p, N); % Simulated result
    end
    
    % Store simulated results in the preallocated cell array
    allSimulatedResults{k} = simulatedResults;  
    
    % Plot individual figures for each K value
    figure;
    plot(p_range, calculatedResults, '-r', 'LineWidth', 2); % Calculated result
    hold on;
    plot(p_range, simulatedResults, 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'none'); % Simulated result
    title(['K = ' num2str(K)]);
    xlabel('Probability (p)');
    ylabel('Number of Transmissions');
    legend('Calculated', 'Simulated');
    grid on;
    hold off;
    
end

% Plot a single figure with results from all K values
figure;
hold on;
for k_index = 1:length(K_Values)
    K = K_Values(k_index);
    simulatedResults = allSimulatedResults{k_index};
    plot(p_range, simulatedResults, 'o-', 'DisplayName', ['K = ', num2str(K)]);
end
title('Combined Simulation Results');
xlabel('Probability (p)');
ylabel('Number of Transmissions (log scale)');
legend('Location', 'Best');
set(gca, 'YScale', 'log');
hold off;
