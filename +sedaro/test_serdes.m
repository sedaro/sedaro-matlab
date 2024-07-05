import sedaro.deserialize
import sedaro.serialize

s = '{"ndarray":[[1,2,3],[120,130,140]]}';
r = deserialize(jsondecode(s));
assert(all(r(1,:) == [1 2 3]));
assert(all(r(2,:) == [120 130 140]));
assert(strcmp(jsonencode(serialize(r)), s));

s = '{"ndarray":[[[1,2],[10,20]],[[3,4],[30,40]]]}';
r = deserialize(jsondecode(s));
assert(all(r(1,:,1) == [1 10]));
assert(all(r(2,:,1) == [3 30]));
assert(all(r(1,:,2) == [2 20]));
assert(all(r(2,:,2) == [4 40]));
assert(strcmp(jsonencode(serialize(r)), s));
assert(all(jsondecode('[12, 14, 15]') == [12; 14; 15]));
assert(strcmp(jsonencode(serialize([12; 14; 15])), '{"ndarray":[12,14,15]}'))

s = '[{"ndarray": [12, 13, 14]}, {"ndarray": [120, 130, 140]}, {"ndarray": [2, 3, 4]}]';
r = deserialize(jsondecode(s));
assert(all(r{1} == [12; 13; 14]));
assert(all(r{2} == [120; 130; 140]));
assert(all(r{3} == [2; 3; 4]));
assert(strcmp(jsonencode(serialize(r)), '[{"ndarray":[12,13,14]},{"ndarray":[120,130,140]},{"ndarray":[2,3,4]}]'));

s = '[{"ndarray":[[1,2],[10,20]]},{"ndarray":[[3,4],[30,40]]}]';
r = deserialize(jsondecode(s));
assert(isequal(r{1}(:, 1), [1; 10]));
assert(isequal(r{2}(:, 1), [3; 30]));
assert(isequal(r{1}(:, 2), [2; 20]));
assert(isequal(r{2}(:, 2), [4; 40]));
assert(strcmp(jsonencode(serialize(r)), s));

r = deserialize(jsondecode('[12, 14, 15]'));
assert(all(r == [12; 14; 15]));
assert(strcmp(jsonencode(serialize([12; 14; 15])), '{"ndarray":[12,14,15]}'));

r = deserialize(jsondecode('[[1, 2, 3], [12, 14, 15]]'));
assert(all(r(1, :) == [1, 2, 3]));
assert(all(r(2, :) == [12, 14, 15]));
assert(strcmp(jsonencode(serialize(r)), '{"ndarray":[[1,2,3],[12,14,15]]}'));

r = deserialize(jsondecode('[12, {"ndarray": [120, 130, 140]}]'));
assert(r{1} == 12);
assert(all(r{2} == [120; 130; 140]));
assert(strcmp(jsonencode(serialize(r)), '[12,{"ndarray":[120,130,140]}]'));

s = '{"ndarray":[120,130,140]}';
r = deserialize(jsondecode(s));
assert(all(r == [120; 130; 140]));
assert(strcmp(jsonencode(serialize(r)), s));

s = '{"m":12,"h":{"ndarray":[120,130,140]}}';
r = deserialize(jsondecode(s));
assert(r.m == 12);
assert(all(r.h == [120; 130; 140]));
assert(strcmp(jsonencode(serialize(r)), s));

s = '[14.1,{"m":12,"h":{"ndarray":[120,130,140]}}]';
r = deserialize(jsondecode(s));
assert(r{1} == 14.1);
assert(r{2}.m == 12);
assert(all(r{2}.h == [120; 130; 140]));
assert(strcmp(jsonencode(serialize(r)), s));


s = '[{"ndarray":[120,130,140]},{"ndarray":[12,13,14,15]}]';
r = deserialize(jsondecode(s));
assert(all(r{1} == [120;130;140]));
assert(all(r{2} == [12;13;14;15]));
assert(strcmp(jsonencode(serialize(r)), s));

disp('All test passed');