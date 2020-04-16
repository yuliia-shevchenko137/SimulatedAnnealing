function [res, b] = Y (j0p, j0m, U0_Ucr, p, omega, Gammap, Gammam)
    [u, b] = U_Ucr(U0_Ucr, p, omega, Gammap, Gammam);
    res = ((1-b)*j0m+b*j0p).*2*(u)./(1+u.^2);
end
