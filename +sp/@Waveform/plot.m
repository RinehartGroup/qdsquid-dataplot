function plot(obj, plot_type, varargin)
    switch plot_type
        case 'fftm'
            disp('fftm');
        case 'fftf'
            disp('fftf');
        otherwise
            plot@sp.Impedence(obj, plot_type, varargin{:});
    end
    %{
    p = inputParser;
    p.addParameter('Temperature', min(obj.Parsed.TemperatureRounded));
    p.parse(varargin{:});
    PlotHelper.plotDataset(obj.Spectra.Frequency, abs(obj.Spectra.hsDFTM), obj.Spectra.Datablock, 'line', 3, '*', p.Unmatched);
    set(gca, 'XScale', 'log');
    %}
end