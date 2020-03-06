
%
% Majorly based on Daniel Halperin's Work, written by Jorge Soriano Cáceres, 2020
%

function ret = csi_per_packets(filename)

    % FOR N ANTENNAE subcarrier 1 only.

    csi_trace = read_bf_file(filename);
    [m, n] = size(csi_trace);
    [a,b,c] = size(csi_trace{1}.csi);
    
    ret = zeros(m,b);
    
    for i = 1:m

        current_csi_entry = csi_trace{i};
        current_csi = get_scaled_csi(current_csi_entry);
        csi_to_plot = db(abs(squeeze(current_csi).'));

        [x,y] = size(csi_to_plot);
        
        %check if antennae used are only 1, if this is the case we must
        % transpose the matrix in order to use it later.
        if x == 1 && y == 30
            csi_to_plot = csi_to_plot.';
            [x,y] = size(csi_to_plot);
        end

        for j = 1:y            
            ret(i,j) = csi_to_plot(1,j);            
        end        
    end
    
    %Interpolate missing packet data (0)
        %goes sideways in matrix
    for k = 1:y           
        %goes from top to bottom in matrix
        for l = 2:m-1
            if ret(l,k) == 0          
                ret(l,k) = (ret(l-1,k) + ret(l+1,k))/2;                
            end            
        end            
    end

end