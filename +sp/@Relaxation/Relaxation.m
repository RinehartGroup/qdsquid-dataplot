classdef Relaxation < handle
    properties
        data = table;
        fits = table;
        model_data = table;
    end
    
    methods
        fit(obj, varargin);
        plot(obj);
        
        function obj = Relaxation(temp, tau)
            obj.data.Temperature = temp;
            obj.data.tau = tau;
        end
    end

    methods (Static)
        output = model(xdata, orbach, raman, qtm, b);
        output = objective(xdata, ydata, orbach, raman, qtm, b);
    end
end