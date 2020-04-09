function parseACData(obj)
    for a = 1:length(obj.DataFiles)
        toAdd = array2table([obj.DataFiles(a).Raw{:, SQUIDDataFile.ACFieldsRaw}], 'VariableNames', SQUIDDataFile.ACFieldsRaw);

        toAdd.TemperatureRounded = round(toAdd.Temperature / 0.02) * 0.02;
        toAdd{:, {'ChiIn', 'ChiInErr', 'ChiOut', 'ChiOutErr'}} = toAdd{:, {'ChiIn', 'ChiInErr', 'ChiOut', 'ChiOutErr'}} ./ obj.DataFiles(a).Header.Moles;
        toDelete = (toAdd.ChiIn < -0.1) | (toAdd.ChiOut < -0.1) | (toAdd.ChiOutErr > 0.0075) | (toAdd.ChiOut > 30);
        numToDelete = nnz(toDelete);
        if numToDelete ~= 0
            toAdd(toDelete, :) = [];
            disp(['Truncated ' num2str(numToDelete) ' datapoints from ' obj.DataFiles(a).Filename]);
        end
        obj.Parsed = [obj.Parsed; toAdd];
    end

    reorder_idxs = [1:2, width(obj.Parsed), 3:(width(obj.Parsed) - 1)];
    obj.Parsed = obj.Parsed(:, reorder_idxs);

    obj.Parsed = sortrows(obj.Parsed, {'TemperatureRounded', 'Frequency'});
end