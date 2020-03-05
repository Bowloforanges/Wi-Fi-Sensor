
%
% Majorly based on Daniel Halperin's Work, written by Jorge Soriano Cáceres, 2020
%

function ret = csi_per_packets(filename)

    % FOR N ANTENNAE subcarrier 1 only.

    csi_trace = read_bf_file(filename);
    [m, n] = size(csi_trace);
    ret = zeros(1,m);

    [a,b,c] = size(csi_trace{1}.csi);
    
    for i = 1:m

        current_csi_entry = csi_trace{i};
        current_csi = get_scaled_csi(current_csi_entry);
        csi_to_plot = db(abs(squeeze(current_csi)));

        for j = 1:b
            
            ret(j,i) = csi_to_plot(j,1);
            
        end

    end

end


