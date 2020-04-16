function fin_result = j_dc (j0, U0_Ucr, omega_tau, alpha, delta)
    fin_result = 0;
    for p = -500:500
      fin_result = fin_result + besselj(p,alpha).^2 .*Y(j0, U0_Ucr, omega_tau, p, delta);
    end
end