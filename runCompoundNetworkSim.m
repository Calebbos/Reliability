function result = runCompoundNetworkSim(K, p, N)
    simResults = zeros(1, N); % preallocate array for simulation results
    
    for i = 1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across
        
        % Parallel link simulation (from a to b)
        while pktSuccessCount < K
            % Simulate transmission on the parallel links
            r1 = rand; % generate random number for link 1
            r2 = rand; % generate random number for link 2
            txAttemptCount = txAttemptCount + 1; % count 1st attempt

            % while packet transmission is not successful on both links
            while r1 < p || r2 < p
                r1 = rand; % generate new success check value for link 1
                r2 = rand; % generate new success check value for link 2
                txAttemptCount = txAttemptCount + 1; % count additional attempt
            end

            pktSuccessCount = pktSuccessCount + 1; % increase success count after success on both links
        end
        
        % Series link simulation (from b to c)
        pktSuccessCount = 0; % reset success count for series link
        
        while pktSuccessCount < K
            % Second link
            r2 = rand; % generate random number to determine if packet is successful (r2 > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt on second link

            % while packet transmission is not successful on the second link (r2 < p)
            while r2 < p
                r2 = rand; % transmit again, generate new success check value r2
                txAttemptCount = txAttemptCount + 1; % count additional attempt
            end

            % If the second link is successful, increase success count
            pktSuccessCount = pktSuccessCount + 1;
        end

        simResults(i) = txAttemptCount; % record total number of attempted transmissions before entire application message (K successful packets) transmitted
    end

    result = mean(simResults);
end
