function result = jls (j0p, j0m, U0_Ucr, omega, Gammap, Gammam, alpha, l, k)
    result = 0;
    for p = -k:k
      c1 = besselj(p,alpha).*(besselj(p+l,alpha)-besselj(p-l,alpha));
      result = result + c1.*K(j0p, j0m, U0_Ucr, p, omega, Gammap, Gammam);
    end
end
