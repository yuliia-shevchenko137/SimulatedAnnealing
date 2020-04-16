function res = jlc (j0p, j0m, U0_Ucr, omega, Gammap, Gammam, alpha, l, k)
    res = 0;
    s = 0;
    for p = -k:k
      c1 = besselj(p,alpha).*(besselj(p+l,alpha)+besselj(p-l,alpha));
      res = res +  c1.*Y(j0p, j0m, U0_Ucr, p, omega, Gammap, Gammam);
    end
end
