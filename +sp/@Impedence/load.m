function load(obj, type)
    file = uigetfile('*.dat', 'MultiSelect', 'on');
    if ~iscell(file), file = {file}; end

    runTypes = {'ac', 'waveform'};
    classTypes = {@sp.AC, @sp.Waveform};
    selector = contains(runTypes, type);

    for a = 1:length(file)
        obj.datafiles = [obj.datafiles classTypes{selector}(file{a})];
    end
end