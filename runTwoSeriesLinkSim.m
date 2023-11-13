%% Function runTwoSeriesLinkSim()
% Parameters
%  K - the number of packets in the application message
%  p - the probability of failure 
%  N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations

function result = runTwoSeriesLinkSim(K, p, N)

    simResults = ones(1, N); % a place to store the result of each simulation
    
    for i = 1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across
    
        while pktSuccessCount < K
            % First link
            r1 = rand; % generate random number to determine if packet is successful (r1 > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt

            % while packet transmission is not successful on the first link (r1 < p)
            while r1 < p
                r1 = rand; % transmit again, generate new success check value r1
                txAttemptCount = txAttemptCount + 1; % count additional attempt
            end

            % If the first link is successful, proceed to the second link
            if r1 >= p
                % Second link
                r2 = rand; % generate random number to determine if packet is successful (r2 > p)
                txAttemptCount = txAttemptCount + 1; % count 1st attempt on second link

                % while packet transmission is not successful on the second link (r2 < p)
                while r2 < p
                    r2 = rand; % transmit again, generate new success check value r2
                    txAttemptCount = txAttemptCount + 1; % count additional attempt
                end

                % If the second link is successful, increase success count
                if r2 >= p
                    pktSuccessCount = pktSuccessCount + 1;
                else
                    % If the second link fails, reset success count to 0
                    pktSuccessCount = 0;
                end
            end
        end

        simResults(i) = txAttemptCount; % record total number of attempted transmissions before entire application message (K successful packets) transmitted
    end

    result = mean(simResults);
end
