% Deserialize cosimulator response
function deserialized_values = deserialize(v)
    if iscell(v)
        deserialized_values = {};
        for i = 1:length(v)
            deserialized_values{i} = sedaro.deserialize(v{i});
        end
    elseif isstruct(v)
        if isfield(v, 'ndarray')
            deserialized_values = {};
            for i = 1:length(v)
                deserialized_values{i} = v(i).ndarray;
            end
            if sedaro.is_struct_array(v) == 0
                deserialized_values = cell2mat(deserialized_values);
                if length(v) > 1
                    deserialized_values = deserialized_values.';
                end
            end
        else
            fields = fieldnames(v);
            deserialized_values = struct();
            for i = 1:length(fields)
                deserialized_values.(fields{i}) = sedaro.deserialize(v.(fields{i}));
            end
        end
    else
        deserialized_values = v;
    end
end