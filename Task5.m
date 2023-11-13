%% Task 5 for runCustomCompoundNetworkSim.m

% Initialize Parameters
K_Values = [1, 5, 15, 50, 100];    % K - the number of packets in the application message
p_values = {
    [0.1, 0.6, 0.5], % Scenario 1
    [0.6, 0.1, 0.5], % Scenario 2
    [0.1, 0.5, 0.6], % Scenario 3
    [0.6, 0.5, 0.1], % Scenario 4
    [0.5, 0.99, 0.1], % Scenario 5
    [0.5, 0.99, 0.6]  % Scenario 6
};
N = 1000;                   % N - the number of simulations to run

% Looping through each scenario
for scenario = 1:length(p_values)
    p = p_values{scenario};
    % Arrays for calculated and simulated results
    calculatedResults = zeros(size(p));
    simulatedResults = zeros(size(p));
    % Calculate results for each K value
    for k = 1:length(K_Values)
        K = K_Values(k);
        simulatedResults(k) = runCustomCompoundNetworkSim(K, p, N); % Simulated result
    end
    
    % Plot individual figures for each scenario
    figure;
    hold on;
    plot(K_Values, simulatedResults, 'MarkerEdgeColor', 'b'); % Simulated result
    title(['Scenario ' num2str(scenario)]);
    xlabel('Number of Packets (K)');
    ylabel('Number of Transmissions (log scale)');
    legend('Location', 'Best');
    set(gca, 'YScale', 'log');
    hold off;
    
end

