NUM_SAMPLES=100;
x = 2;
for j = 1.0:1.0:1.0
    attr = 'name';
    attr_value = 'dots_data';
    k = num2str(j);
    file_name = ['starburst_' k '.h5'];
    hdf5write(file_name, attr, attr_value);
    
    c = 1;
    for a = 0.95
        for b = 0.95
            for theta = 0.
                for num_trans = [1, 2, 4]
                    for num_dots = [100, 200, 400]
                        current_s = struct('a',a,'b',b,'theta',theta/pi, 'num_trans', num_trans, 'num_dots', num_dots);
                        x_array = zeros(NUM_SAMPLES, 2, num_dots*2^num_trans);
                        for i = 1:NUM_SAMPLES
                            [e, x] = dots(current_s.a,current_s.b,current_s.theta,current_s.num_trans,current_s.num_dots);
                            x_array(i,:,:) = x;
    %                         dots_s(c) = struct('e',e,'x',x_array);
                        end
                        x_dset = hdf5.h5array(x_array);
                        e_dset = hdf5.h5array(e);
                    
                        path_name = [num2str(a) '/' num2str(b) '/' num2str(theta) '/' num2str(num_trans) '/' num2str(num_dots)];
                        hdf5write(file_name, [path_name '/e'], e_dset, 'WriteMode', 'append');
                        hdf5write(file_name, [path_name '/x'], x_dset, 'WriteMode', 'append');
                        c = c+1;
    
                    end
                end
            end
        end
    end
end
%%
i=1;

figure; 
plot(x(1,:),x(2,:),'.');
title('Random Dot Interference Pattern ');


txt=['with eigenvalues:    ' num2str(e(1)) '   and    ' num2str(e(2)) newline ...
    'a=' num2str(current_s.a) ' b=' num2str(current_s.b) ' theta=' num2str(current_s.theta) ...
    ' NumTrans=' num2str(current_s.num_trans) ' NumDots=' num2str(current_s.num_trans)];
xlabel(txt);