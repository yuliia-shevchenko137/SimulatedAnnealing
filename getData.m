function [ out ] = getData( name )
    f1 = fopen(name);
    line = fgetl(f1);
    A = [];
    while ~isequal(line,'')
        split = strsplit(line);
        A = [A; split];
        line = fgetl(f1);
    end
    fclose(f1);
    siz = size(A);
    A1 = A(:, 1);
    A2 = A(:, 2);
    for i = 1:siz(1,1)
        a = A2{i,1};
        C(i,1) = str2num(a);
    end
    for i = 1:siz(1,1)
        a = A1{i,1};
        B(i,1) = str2num(a);
    end
    out = [B C];
end

