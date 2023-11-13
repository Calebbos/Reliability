function result = runCustomCompoundNetworkSim(K, p_values, N)
    simResults = zeros(1, N); % preallocate array for simulation results
    
    for i = 1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across
        
        % Compound link simulation
        for j = 1:length(p_values)
            p = p_values{j};
            
            % Parallel link simulation
            while pktSuccessCount < K
                % Simulate transmission on the parallel links
                for link = 1:length(p)
                    r = rand; % generate random number for the link
                    txAttemptCount = txAttemptCount + 1; % count 1st attempt

                    % while packet transmission is not successful on the link
                    while r < p(link)
                        r = rand; % generate new success check value for the link
                        txAttemptCount = txAttemptCount + 1; % count additional attempt
                    end
                end

                pktSuccessCount = pktSuccessCount + 1; % increase success count after success on all links
            end

            % Reset success count for the next scenario
            pktSuccessCount = 0;
        end

        simResults(i) = txAttemptCount; % record total number of attempted transmissions before entire application message (K successful packets) transmitted
    end

    result = mean(simResults);
end
