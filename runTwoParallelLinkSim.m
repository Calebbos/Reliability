%% Function runTwoParallelLinkSim()
% Parameters
%  K - the number of packets in the application message
%  p - the probability of failure 
%  N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations

function result = runTwoParallelLinkSim(K, p, N)
    simResults = ones(1, N); % a place to store the result of each simulation

    for i = 1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

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

        simResults(i) = txAttemptCount; % record total number of attempted transmissions before entire application msg (K successful packets) transmitted
    end

    result = mean(simResults);
end
