% Serialize cosimulator request
function serialized_values = serialize(v)
    if iscell(v)
        serialized_values = {};
        for i = 1:length(v)
            serialized_values{i} = sedaro.serialize(v{i});
        end
    elseif ndims(v) > 1 && isnumeric(v) && ~isscalar(v)
        serialized_values = struct('ndarray', v);
    elseif isstruct(v)
        fields = fieldnames(v);
        serialized_values = struct();
        for i = 1:length(fields)
            serialized_values.(fields{i}) = sedaro.serialize(v.(fields{i}));
        end
    else
        serialized_values = v;
    end
end

